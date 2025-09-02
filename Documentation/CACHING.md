# Rebrickable Swift API Client - Caching Documentation

## Overview

The Rebrickable Swift API Client includes a comprehensive caching infrastructure designed to improve performance, reduce network requests, and provide offline capabilities. The caching system is built with modern Swift concurrency features and provides flexible configuration options.

## Table of Contents

- [Quick Start](#quick-start)
- [Architecture](#architecture)
- [Configuration](#configuration)
- [Usage Examples](#usage-examples)
- [Cache Management](#cache-management)
- [Advanced Features](#advanced-features)
- [Best Practices](#best-practices)
- [API Reference](#api-reference)
- [Troubleshooting](#troubleshooting)

## Quick Start

### Basic Usage

```swift
import RebrickableLegoAPIClient

// Enable caching with default settings
RebrickableLegoAPIClientAPIConfiguration.shared.enableCaching()

// All API calls now use caching automatically
let colors = try await LegoAPI.legoColorsList()

// Second call returns from cache if within expiration time
let cachedColors = try await LegoAPI.legoColorsList()
```

### Custom Configuration

```swift
// Create a configuration with custom cache settings
let config = RebrickableLegoAPIClientAPIConfiguration.withCaching(
    cacheConfiguration: .production,
    apiKey: "your-api-key-here"
)

// Use the cached configuration
let parts = try await LegoAPI.legoPartsList(apiConfiguration: config)
```

## Architecture

### Core Components

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   LegoAPI       │───▶│ RequestBuilder   │───▶│ CachingLayer    │
│   (Entry Point) │    │ (HTTP Requests)  │    │ (Storage)       │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │                        │
                                ▼                        ▼
                       ┌──────────────────┐    ┌─────────────────┐
                       │ Network Request  │    │ Memory Cache    │
                       │ (URLSession)     │    │ (Actor-based)   │
                       └──────────────────┘    └─────────────────┘
```

### Key Classes

1. **`MemoryCache<Key, Value>`**: Thread-safe in-memory cache with LRU eviction
2. **`APICache`**: High-level cache manager for API responses
3. **`CacheConfiguration`**: Configuration system for cache behavior
4. **`CachingInterceptor`**: Network interceptor for cache integration
5. **`CachedDecodableRequestBuilder`**: Enhanced request builder with caching

## Configuration

### Cache Configuration Types

#### Predefined Configurations

```swift
// Default configuration (5 minutes default expiration)
let defaultConfig = CacheConfiguration.default

// Aggressive caching (30 minutes default, larger cache size)
let aggressiveConfig = CacheConfiguration.aggressive

// Conservative caching (1 minute default, smaller cache size)
let conservativeConfig = CacheConfiguration.conservative

// Development-friendly (30 seconds for quick testing)
let devConfig = CacheConfiguration.development

// Production-optimized (tailored for LEGO data patterns)
let prodConfig = CacheConfiguration.production

// Disabled caching
let noCache = CacheConfiguration.disabled
```

#### Custom Configuration

```swift
let customConfig = CacheConfiguration(
    isEnabled: true,
    defaultExpiration: .after(600), // 10 minutes
    maxMemoryCacheSize: 200,
    endpointConfigurations: [
        "/api/v3/lego/colors/": EndpointCacheConfiguration(
            expiration: .after(3600) // 1 hour for colors
        ),
        "/api/v3/lego/parts/": EndpointCacheConfiguration(
            expiration: .after(1800) // 30 minutes for parts
        )
    ]
)
```

### Expiration Policies

```swift
// Never expires
.never

// Expires after a duration
.after(300) // 5 minutes

// Expires at specific time
.at(Date().addingTimeInterval(3600)) // 1 hour from now
```

## Usage Examples

### Basic API Calls with Caching

```swift
import RebrickableLegoAPIClient

class LegoDataManager {
    private let apiConfig: RebrickableLegoAPIClientAPIConfiguration
    
    init(apiKey: String) {
        // Create cached configuration
        self.apiConfig = .withCaching(
            cacheConfiguration: .production,
            apiKey: apiKey
        )
    }
    
    func loadColors() async throws -> ColorsList {
        // This call will be cached for 24 hours (production config)
        return try await LegoAPI.legoColorsList(apiConfiguration: apiConfig)
    }
    
    func loadParts(page: Int = 1) async throws -> PartsList {
        // Cached for 2 hours with page parameter included in cache key
        return try await LegoAPI.legoPartsList(
            page: page,
            apiConfiguration: apiConfig
        )
    }
    
    func loadThemes() async throws -> ThemesList {
        // Cached for 12 hours (themes are very stable)
        return try await LegoAPI.legoThemesList(apiConfiguration: apiConfig)
    }
}
```

### Error Handling with Cache Fallback

```swift
func loadDataWithFallback() async -> ColorsList? {
    let config = CacheConfiguration(
        endpointConfigurations: [
            "/api/v3/lego/colors/": EndpointCacheConfiguration(
                expiration: .after(3600),
                shouldCacheOnError: true // Enable fallback to stale cache
            )
        ]
    )
    
    let apiConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
        cacheConfiguration: config
    )
    
    do {
        return try await LegoAPI.legoColorsList(apiConfiguration: apiConfig)
    } catch {
        print("Network error: \(error)")
        // Cache might serve stale data automatically if configured
        return nil
    }
}
```

### Conditional Caching Based on Parameters

```swift
class SmartCacheManager {
    func loadPartsWithSmartCaching(
        partNum: String? = nil,
        search: String? = nil
    ) async throws -> PartsList {
        
        // Use longer cache for specific part lookups
        let expiration: CacheExpiration = partNum != nil ? .after(7200) : .after(600)
        
        let config = CacheConfiguration(
            defaultExpiration: expiration,
            maxMemoryCacheSize: 300
        )
        
        let apiConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
            cacheConfiguration: config
        )
        
        return try await LegoAPI.legoPartsList(
            partNum: partNum,
            search: search,
            apiConfiguration: apiConfig
        )
    }
}
```

## Cache Management

### Manual Cache Control

```swift
class CacheManager {
    private let apiCache = APICache.shared
    
    func getCacheStatus() async -> (size: Int, isEmpty: Bool) {
        let size = await apiCache.cacheSize
        let isEmpty = await apiCache.isEmpty
        return (size, isEmpty)
    }
    
    func clearAllCache() async {
        await apiCache.clear()
        print("Cache cleared")
    }
    
    func clearSpecificEndpoint(endpoint: String) async {
        let key = APICacheKey(endpoint: endpoint)
        await apiCache.remove(key: key)
    }
    
    func clearColorsCache() async {
        await clearSpecificEndpoint(endpoint: "/api/v3/lego/colors/")
    }
    
    func clearPartsCache() async {
        await clearSpecificEndpoint(endpoint: "/api/v3/lego/parts/")
    }
}
```

### Cache Key Management

```swift
// Create cache keys manually
let simpleKey = APICacheKey(endpoint: "/api/v3/lego/colors/")

let parameterizedKey = APICacheKey(
    endpoint: "/api/v3/lego/parts/",
    parameters: [
        "page": "1",
        "page_size": "20",
        "part_cat_id": "123"
    ]
)

// Create from URL
let urlKey = APICacheKey.fromURL(
    "https://rebrickable.com/api/v3/lego/sets/?theme_id=1",
    parameters: ["custom": "value"]
)
```

## Advanced Features

### Custom Cache Implementation

```swift
// Implement your own cache storage
class DiskCache<Key: CacheKeyProtocol, Value: Codable & Sendable>: CacheProtocol {
    private let directory: URL
    
    init(directory: URL) {
        self.directory = directory
    }
    
    func get(key: Key) async throws -> Value? {
        let fileURL = directory.appendingPathComponent(key.stringValue)
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }
        
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(Value.self, from: data)
    }
    
    func set(key: Key, value: Value, expiration: CacheExpiration?) async throws {
        let data = try JSONEncoder().encode(value)
        let fileURL = directory.appendingPathComponent(key.stringValue)
        try data.write(to: fileURL)
    }
    
    // Implement remaining protocol methods...
}
```

### Cache Metrics and Monitoring

```swift
class CacheMetrics {
    private var hitCount = 0
    private var missCount = 0
    
    func recordHit() {
        hitCount += 1
    }
    
    func recordMiss() {
        missCount += 1
    }
    
    var hitRate: Double {
        let total = hitCount + missCount
        return total > 0 ? Double(hitCount) / Double(total) : 0.0
    }
    
    func reset() {
        hitCount = 0
        missCount = 0
    }
}
```

## Best Practices

### 1. Choose Appropriate Expiration Times

```swift
// Static data - cache longer
let staticDataConfig = [
    "/api/v3/lego/colors/": EndpointCacheConfiguration(
        expiration: .after(86400) // 24 hours
    ),
    "/api/v3/lego/themes/": EndpointCacheConfiguration(
        expiration: .after(43200) // 12 hours
    )
]

// Dynamic data - shorter cache times
let dynamicDataConfig = [
    "/api/v3/lego/sets/": EndpointCacheConfiguration(
        expiration: .after(900) // 15 minutes
    )
]
```

### 2. Handle Memory Pressure

```swift
// Configure appropriate cache sizes
let lowMemoryConfig = CacheConfiguration(
    maxMemoryCacheSize: 50 // Smaller cache for memory-constrained environments
)

let highMemoryConfig = CacheConfiguration(
    maxMemoryCacheSize: 1000 // Larger cache for performance-critical apps
)
```

### 3. Environment-Specific Configurations

```swift
class ConfigurationFactory {
    static func createConfiguration(for environment: Environment) -> CacheConfiguration {
        switch environment {
        case .development:
            return .development // Short expiration for testing
        case .testing:
            return .disabled // No caching during tests
        case .production:
            return .production // Optimized for real-world usage
        }
    }
}
```

### 4. Error Handling

```swift
func robustAPICall<T>(_ apiCall: () async throws -> T) async -> T? {
    do {
        return try await apiCall()
    } catch {
        print("API call failed: \(error)")
        // Cache might provide fallback data automatically
        return nil
    }
}
```

## API Reference

### CacheConfiguration

```swift
public struct CacheConfiguration: Sendable {
    public let isEnabled: Bool
    public let defaultExpiration: CacheExpiration
    public let maxMemoryCacheSize: Int
    public let endpointConfigurations: [String: EndpointCacheConfiguration]
}
```

### CacheExpiration

```swift
public enum CacheExpiration: Sendable {
    case never
    case after(TimeInterval)
    case at(Date)
}
```

### APICache

```swift
public final class APICache: @unchecked Sendable {
    public static let shared: APICache
    
    public func cacheResponse<T: Decodable & Sendable>(
        _ response: Response<T>,
        for key: APICacheKey,
        expiration: CacheExpiration?
    ) async
    
    public func getCachedResponse<T: Decodable>(
        for key: APICacheKey,
        type: T.Type,
        codableHelper: CodableHelper
    ) async -> Response<T>?
    
    public func clear() async
    public func remove(key: APICacheKey) async
    
    public var cacheSize: Int { get async }
    public var isEmpty: Bool { get async }
}
```

### APICacheKey

```swift
public struct APICacheKey: CacheKeyProtocol {
    public let endpoint: String
    public let parameters: [String: String]
    
    public init(endpoint: String, parameters: [String: String] = [:])
    public static func fromURL(_ urlString: String, parameters: [String: any Sendable]?) -> APICacheKey
}
```

## Troubleshooting

### Common Issues

#### Cache Not Working

```swift
// Check if caching is enabled
let config = RebrickableLegoAPIClientAPIConfiguration.shared
print("Caching enabled: \(config.interceptor is CachingInterceptor)")

// Verify cache configuration
if let cachingInterceptor = config.interceptor as? CachingInterceptor {
    // Check configuration details
}
```

#### Memory Usage Too High

```swift
// Reduce cache size
let smallerConfig = CacheConfiguration(maxMemoryCacheSize: 50)

// Or clear cache periodically
Task {
    while true {
        try await Task.sleep(nanoseconds: 3600_000_000_000) // 1 hour
        await APICache.shared.clear()
    }
}
```

#### Stale Data Issues

```swift
// Use shorter expiration times for critical data
let freshConfig = CacheConfiguration(
    endpointConfigurations: [
        "/api/v3/lego/sets/": EndpointCacheConfiguration(
            expiration: .after(60) // 1 minute for fresh data
        )
    ]
)
```

### Debug Logging

```swift
// Enable debug logging in development
#if DEBUG
extension APICache {
    func logCacheState() async {
        let size = await cacheSize
        print("Cache size: \(size)")
    }
}
#endif
```

### Performance Monitoring

```swift
class CachePerformanceMonitor {
    func measureCachePerformance<T>(
        operation: () async throws -> T
    ) async rethrows -> (result: T, duration: TimeInterval) {
        let startTime = CFAbsoluteTimeGetCurrent()
        let result = try await operation()
        let duration = CFAbsoluteTimeGetCurrent() - startTime
        
        print("Cache operation took \(duration * 1000)ms")
        return (result, duration)
    }
}
```

## Migration Guide

### From Non-Cached to Cached

```swift
// Before (no caching)
let colors = try await LegoAPI.legoColorsList()

// After (with caching)
RebrickableLegoAPIClientAPIConfiguration.shared.enableCaching()
let colors = try await LegoAPI.legoColorsList() // Now cached!
```

### Updating Cache Configuration

```swift
// Update existing configuration
let currentConfig = RebrickableLegoAPIClientAPIConfiguration.shared
currentConfig.enableCaching(with: .production)

// Or create new configuration
let newConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
    cacheConfiguration: .production
)
```

---

This caching system provides a robust, performant, and flexible foundation for the Rebrickable Swift API Client. For additional questions or support, please refer to the source code or create an issue in the project repository.