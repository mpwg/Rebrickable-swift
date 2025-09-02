# Caching API Reference

## Core Protocols

### `CacheProtocol`

Generic protocol for cache implementations.

```swift
public protocol CacheProtocol: Sendable {
    associatedtype Key: Hashable & Sendable
    associatedtype Value: Sendable
    
    func get(key: Key) async throws -> Value?
    func set(key: Key, value: Value, expiration: CacheExpiration?) async throws
    func remove(key: Key) async throws
    func clear() async throws
    func contains(key: Key) async -> Bool
}
```

**Methods:**
- `get(key:)`: Retrieve value for key, throws `CacheError.expired` if expired
- `set(key:value:expiration:)`: Store value with optional expiration
- `remove(key:)`: Remove specific cache entry
- `clear()`: Remove all cache entries
- `contains(key:)`: Check if key exists and is not expired

### `CacheKeyProtocol`

Protocol for cache keys.

```swift
public protocol CacheKeyProtocol: Hashable, Sendable {
    var stringValue: String { get }
}
```

## Core Classes

### `MemoryCache<Key, Value>`

Thread-safe in-memory cache with LRU eviction.

```swift
public actor MemoryCache<Key: CacheKeyProtocol, Value: Sendable>: CacheProtocol {
    public init(maxSize: Int = 100)
    
    // CacheProtocol methods
    public func get(key: Key) async throws -> Value?
    public func set(key: Key, value: Value, expiration: CacheExpiration?) async throws
    public func remove(key: Key) async throws
    public func clear() async throws
    public func contains(key: Key) async -> Bool
    
    // Additional properties
    public var count: Int { get async }
    public var isEmpty: Bool { get async }
}
```

**Features:**
- LRU (Least Recently Used) eviction when cache exceeds `maxSize`
- Automatic cleanup of expired items
- Thread-safe operations using Swift actors

### `APICache`

High-level cache manager for API responses.

```swift
public final class APICache: @unchecked Sendable {
    public static let shared: APICache
    
    public init(configuration: CacheConfiguration = .customConfiguration())
    
    // Generic response caching
    public func cacheResponse<T: Decodable & Sendable>(
        _ response: Response<T>,
        for key: APICacheKey,
        expiration: CacheExpiration? = nil
    ) async
    
    // Generic response retrieval
    public func getCachedResponse<T: Decodable>(
        for key: APICacheKey,
        type: T.Type,
        codableHelper: CodableHelper
    ) async -> Response<T>?
    
    // Cache management
    public func clear() async
    public func remove(key: APICacheKey) async
    
    // Cache status
    public var cacheSize: Int { get async }
    public var isEmpty: Bool { get async }
}
```

### `APICacheKey`

Cache key implementation for API endpoints.

```swift
public struct APICacheKey: CacheKeyProtocol {
    public let endpoint: String
    public let parameters: [String: String]
    
    public init(endpoint: String, parameters: [String: String] = [:])
    
    public var stringValue: String { get }
    
    // Convenience factory method
    public static func fromURL(
        _ urlString: String,
        parameters: [String: any Sendable]? = nil
    ) -> APICacheKey
}
```

**Features:**
- Deterministic string representation for consistent caching
- Parameter order normalization (sorted keys)
- URL parsing for easy key creation

## Configuration

### `CacheConfiguration`

Main configuration structure for cache behavior.

```swift
public struct CacheConfiguration: Sendable {
    public let isEnabled: Bool
    public let defaultExpiration: CacheExpiration
    public let maxMemoryCacheSize: Int
    public let endpointConfigurations: [String: EndpointCacheConfiguration]
    
    public init(
        isEnabled: Bool = true,
        defaultExpiration: CacheExpiration = .after(300),
        maxMemoryCacheSize: Int = 100,
        endpointConfigurations: [String: EndpointCacheConfiguration] = [:]
    )
    
    public func configurationFor(endpoint: String) -> EndpointCacheConfiguration
    
    // Predefined configurations
    public static let `default`: CacheConfiguration
    public static let aggressive: CacheConfiguration
    public static let conservative: CacheConfiguration
    public static let disabled: CacheConfiguration
    public static let development: CacheConfiguration
    public static let production: CacheConfiguration
    
    // Factory method for custom LEGO-optimized configuration
    public static func customConfiguration() -> CacheConfiguration
}
```

### `EndpointCacheConfiguration`

Configuration for specific API endpoints.

```swift
public struct EndpointCacheConfiguration: Sendable {
    public let isEnabled: Bool
    public let expiration: CacheExpiration
    public let shouldCacheOnError: Bool
    
    public init(
        isEnabled: Bool = true,
        expiration: CacheExpiration = .after(300),
        shouldCacheOnError: Bool = false
    )
}
```

### `CacheExpiration`

Expiration policy for cached items.

```swift
public enum CacheExpiration: Sendable {
    case never
    case after(TimeInterval)
    case at(Date)
    
    var expirationDate: Date? { get }
    func isExpired(at date: Date = Date()) -> Bool
}
```

**Cases:**
- `.never`: Items never expire
- `.after(TimeInterval)`: Items expire after specified seconds
- `.at(Date)`: Items expire at specific date/time

## Request Builders

### `CachedDecodableRequestBuilder<T>`

Enhanced request builder with automatic caching.

```swift
open class CachedDecodableRequestBuilder<T: Decodable & Sendable>: URLSessionDecodableRequestBuilder<T> {
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    override open func execute() async throws(ErrorResponse) -> Response<T>
}
```

**Features:**
- Automatic cache lookup for GET requests
- Automatic caching of successful responses
- Transparent fallback to network requests
- Uses shared `APICache` instance

### `CachedRequestBuilderFactory`

Factory for creating cached request builders.

```swift
public class CachedRequestBuilderFactory: RequestBuilderFactory {
    public init(cacheConfiguration: CacheConfiguration = .customConfiguration())
    
    public func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type
    public func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type
}
```

## Integration

### `CachingInterceptor`

OpenAPI interceptor for network-level caching integration.

```swift
public class CachingInterceptor: OpenAPIInterceptor {
    public init(configuration: CacheConfiguration = .customConfiguration())
    
    public func intercept<T>(
        urlRequest: URLRequest,
        urlSession: URLSessionProtocol,
        requestBuilder: RequestBuilder<T>,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    )
    
    public func retry<T>(
        urlRequest: URLRequest,
        urlSession: URLSessionProtocol,
        requestBuilder: RequestBuilder<T>,
        data: Data?,
        response: URLResponse?,
        error: Error,
        completion: @escaping (OpenAPIInterceptorRetry) -> Void
    )
}
```

## Extensions

### `RebrickableLegoAPIClientAPIConfiguration` Extensions

```swift
public extension RebrickableLegoAPIClientAPIConfiguration {
    // Create new cached configuration
    static func withCaching(
        cacheConfiguration: CacheConfiguration = .customConfiguration(),
        basePath: String = "https://rebrickable.com",
        apiKey: String? = nil
    ) -> RebrickableLegoAPIClientAPIConfiguration
    
    // Enable caching on existing configuration
    func enableCaching(
        with cacheConfiguration: CacheConfiguration = .customConfiguration()
    )
}
```

## Error Types

### `CacheError`

```swift
public enum CacheError: Error {
    case invalidKey
    case expired
    case notFound
    case serializationFailed
    case deserializationFailed
}
```

## Internal Types

### `CachedResponse`

Internal structure for storing HTTP responses.

```swift
internal struct CachedResponse: Sendable {
    let data: Data?
    let statusCode: Int
    let headers: [String: String]
    let createdAt: Date
    
    init(data: Data?, statusCode: Int, headers: [String: String], createdAt: Date = Date())
}
```

### `CachedItem<Value>`

Internal wrapper for cached values with metadata.

```swift
internal struct CachedItem<Value: Sendable>: Sendable {
    let value: Value
    let expirationDate: Date?
    let createdAt: Date
    
    init(value: Value, expiration: CacheExpiration?)
    func isExpired(at date: Date = Date()) -> Bool
}
```

## Usage Patterns

### Configuration Factory

```swift
class CacheConfigurationFactory {
    static func forEnvironment(_ env: Environment) -> CacheConfiguration {
        switch env {
        case .development: return .development
        case .production: return .production
        case .testing: return .disabled
        }
    }
    
    static func forDataType(_ type: LEGODataType) -> EndpointCacheConfiguration {
        switch type {
        case .colors, .themes: 
            return EndpointCacheConfiguration(expiration: .after(3600)) // 1 hour
        case .parts:
            return EndpointCacheConfiguration(expiration: .after(1800)) // 30 minutes
        case .sets:
            return EndpointCacheConfiguration(expiration: .after(900))  // 15 minutes
        }
    }
}
```

### Cache Manager Utility

```swift
class CacheManager {
    static let shared = CacheManager()
    private let cache = APICache.shared
    
    func clearExpiredData() async {
        // Expired items are automatically cleaned up
        // This method could trigger manual cleanup if needed
    }
    
    func getCacheStatistics() async -> CacheStatistics {
        return CacheStatistics(
            size: await cache.cacheSize,
            isEmpty: await cache.isEmpty
        )
    }
    
    func preloadCommonData() async throws {
        // Pre-populate cache with frequently accessed data
        let config = RebrickableLegoAPIClientAPIConfiguration.shared
        _ = try await LegoAPI.legoColorsList(apiConfiguration: config)
        _ = try await LegoAPI.legoThemesList(apiConfiguration: config)
    }
}

struct CacheStatistics {
    let size: Int
    let isEmpty: Bool
    
    var description: String {
        isEmpty ? "Cache is empty" : "Cache contains \(size) items"
    }
}
```

## Thread Safety

All cache operations are thread-safe:

- `MemoryCache` uses Swift actors for thread safety
- `APICache` is marked as `@unchecked Sendable` with internal synchronization
- All public methods are safe to call from any thread/task
- Concurrent reads and writes are handled safely

## Performance Characteristics

### Time Complexity
- `get(key:)`: O(1) average, O(n) worst case for cleanup
- `set(key:value:expiration:)`: O(1) average, O(n) for LRU maintenance
- `remove(key:)`: O(n) for LRU list maintenance
- `clear()`: O(n)
- `contains(key:)`: O(1) average

### Space Complexity
- O(n) where n is the number of cached items
- LRU eviction maintains memory bounds
- Expired items are cleaned up automatically

### Memory Management
- Weak references where appropriate
- Automatic cleanup of expired items
- Configurable memory limits with LRU eviction
- No retain cycles in the caching system