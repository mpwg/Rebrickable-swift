// DatabaseCachedRequestBuilder.swift
//
// Request builder that integrates database caching for single entities
//

import Foundation

// Database-aware request builder for single entity endpoints
open class DatabaseCachedRequestBuilder<T: Decodable & Sendable>: URLSessionDecodableRequestBuilder<T>, @unchecked Sendable {
    private static var databaseCache: DatabaseCache {
        DatabaseCache.shared
    }
    
    private let databaseConfig: DatabaseCacheConfiguration
    
    public init(
        method: String,
        URLString: String,
        parameters: [String: any Sendable]?,
        headers: [String: String] = [:],
        requiresAuthentication: Bool,
        apiConfiguration: RebrickableLegoAPIClientAPIConfiguration = RebrickableLegoAPIClientAPIConfiguration.shared,
        databaseConfig: DatabaseCacheConfiguration = .longTerm
    ) {
        self.databaseConfig = databaseConfig
        super.init(
            method: method,
            URLString: URLString,
            parameters: parameters,
            headers: headers,
            requiresAuthentication: requiresAuthentication,
            apiConfiguration: apiConfiguration
        )
    }
    
    public required init(
        method: String,
        URLString: String,
        parameters: [String: any Sendable]?,
        headers: [String: String] = [:],
        requiresAuthentication: Bool,
        apiConfiguration: RebrickableLegoAPIClientAPIConfiguration = RebrickableLegoAPIClientAPIConfiguration.shared
    ) {
        self.databaseConfig = .longTerm
        super.init(
            method: method,
            URLString: URLString,
            parameters: parameters,
            headers: headers,
            requiresAuthentication: requiresAuthentication,
            apiConfiguration: apiConfiguration
        )
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    override open func execute() async throws(ErrorResponse) -> Response<T> {
        // Only apply database caching to GET requests for single entities
        guard method.uppercased() == "GET" && isSingleEntityEndpoint() else {
            return try await super.execute()
        }
        
        // Check if database caching is enabled
        guard databaseConfig.isEnabled else {
            return try await super.execute()
        }
        
        // Try to get from database cache first (only if T is DatabaseCacheable)
        if let primaryKey = extractPrimaryKey() {
            
            do {
                // Handle PartColor with composite keys specially
                if T.self == PartColor.self && primaryKey.contains("_") {
                    let cachedWrapper = try await Self.databaseCache.retrieve(
                        type: CompositeKeyPartColor.self,
                        primaryKey: primaryKey
                    )
                    
                    if let wrapper = cachedWrapper,
                       let partColor = wrapper.partColor as? T {
                        let response = Response<T>(
                            statusCode: 200,
                            header: ["Content-Type": "application/json", "X-Cache": "database-hit"],
                            body: partColor,
                            bodyData: nil
                        )
                        return response
                    }
                } else if let cacheableType = T.self as? any DatabaseCacheable.Type {
                    // Standard single key entities
                    let cachedEntity = try await Self.databaseCache.retrieve(
                        type: cacheableType,
                        primaryKey: primaryKey
                    )
                    
                    if let cached = cachedEntity as? T {
                        let response = Response<T>(
                            statusCode: 200,
                            header: ["Content-Type": "application/json", "X-Cache": "database-hit"],
                            body: cached,
                            bodyData: nil
                        )
                        return response
                    }
                }
            } catch {
                // Cache error, continue with network request
                print("Database cache error: \(error)")
            }
        }
        
        // Execute network request
        do {
            let response = try await super.execute()
            
            // Store successful responses in database cache (if entity is DatabaseCacheable)
            if let primaryKey = extractPrimaryKey(),
               let entity = response.body as? any DatabaseCacheable {
                
                Task {
                    do {
                        // For complex entities like PartColor, override the primary key
                        if let partColor = entity as? PartColor,
                           primaryKey.contains("_") {
                            // Store with the composite key extracted from URL
                            try await Self.databaseCache.store(
                                entity: CompositeKeyPartColor(partColor: partColor, compositeKey: primaryKey),
                                expiration: databaseConfig.configurationFor(entityType: PartColor.tableName).expiration
                            )
                        } else {
                            try await Self.databaseCache.storeEntity(entity, configuration: databaseConfig)
                        }
                    } catch {
                        print("Failed to cache entity in database: \(error)")
                    }
                }
            }
            
            return response
        } catch let error {
            // On network error, try to serve from database if available and configured
            if shouldServeStaleOnError(),
               let primaryKey = extractPrimaryKey() {
                
                do {
                    // Handle PartColor with composite keys specially
                    if T.self == PartColor.self && primaryKey.contains("_") {
                        let staleWrapper = try await Self.databaseCache.retrieve(
                            type: CompositeKeyPartColor.self,
                            primaryKey: primaryKey
                        )
                        
                        if let wrapper = staleWrapper,
                           let partColor = wrapper.partColor as? T {
                            let response = Response<T>(
                                statusCode: 200,
                                header: ["Content-Type": "application/json", "X-Cache": "database-stale"],
                                body: partColor,
                                bodyData: nil
                            )
                            return response
                        }
                    } else if let cacheableType = T.self as? any DatabaseCacheable.Type {
                        let staleEntity = try await Self.databaseCache.retrieve(
                            type: cacheableType,
                            primaryKey: primaryKey
                        )
                        
                        if let cached = staleEntity as? T {
                            let response = Response<T>(
                                statusCode: 200,
                                header: ["Content-Type": "application/json", "X-Cache": "database-stale"],
                                body: cached,
                                bodyData: nil
                            )
                            return response
                        }
                    }
                } catch {
                    // Both network and cache failed, rethrow original error
                }
            }
            
            throw error
        }
    }
    
    private func isSingleEntityEndpoint() -> Bool {
        // Check if this is a single entity endpoint (contains path parameter)
        let url = URL(string: URLString)
        let path = url?.path ?? URLString
        
        // Single entity endpoints typically have path parameters like /api/v3/lego/colors/{id}/
        return path.contains("{") || 
               path.matches(pattern: "/[^/]+/$") // Ends with an ID and slash
    }
    
    private func extractPrimaryKey() -> String? {
        // Extract primary key from URL path
        guard let url = URL(string: URLString) else { return nil }
        
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        let path = url.path
        
        // Handle different endpoint patterns:
        
        // 1. Simple single ID endpoints: /api/v3/lego/colors/1/
        if pathComponents.count >= 4 {
            let lastComponent = pathComponents.last ?? ""
            let cleanedComponent = lastComponent.hasSuffix("/") ? 
                String(lastComponent.dropLast()) : lastComponent
            
            // Check if this is a complex endpoint like part colors
            if path.contains("/parts/") && path.contains("/colors/") {
                // Pattern: /api/v3/lego/parts/{part_num}/colors/{color_id}/
                // Extract both part_num and color_id
                if pathComponents.count >= 6 {
                    let partNum = pathComponents[pathComponents.count - 3]
                    let colorId = pathComponents[pathComponents.count - 1].hasSuffix("/") ?
                        String(pathComponents[pathComponents.count - 1].dropLast()) :
                        pathComponents[pathComponents.count - 1]
                    return "\(partNum)_\(colorId)"
                }
            }
            
            // Standard single ID endpoint
            if !cleanedComponent.isEmpty && cleanedComponent != "colors" && cleanedComponent != "parts" {
                return cleanedComponent
            }
        }
        
        return nil
    }
    
    private func shouldServeStaleOnError() -> Bool {
        // Check if any entity configuration allows serving stale data
        let hasErrorCaching = databaseConfig.entityConfigurations.values.contains { $0.shouldCacheOnError }
        
        // Check if default expiration is not never
        let hasExpiration: Bool
        if case .never = databaseConfig.defaultExpiration {
            hasExpiration = false
        } else {
            hasExpiration = true
        }
        
        return hasErrorCaching || hasExpiration
    }
}

// Wrapper for PartColor to use composite keys
private struct CompositeKeyPartColor: DatabaseCacheable, Codable, Sendable {
    let partColor: PartColor
    let compositeKey: String
    
    var primaryKey: String {
        return compositeKey
    }
    
    static var tableName: String {
        return "part_colors"
    }
}

// Extension to String for regex matching
private extension String {
    func matches(pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: self.utf16.count)
            return regex.firstMatch(in: self, options: [], range: range) != nil
        } catch {
            return false
        }
    }
}

// Enhanced cache manager that combines memory and database caching
public final class HybridCache: @unchecked Sendable {
    public static let shared = HybridCache()
    
    private let memoryCache = APICache.shared
    private let databaseCache = DatabaseCache.shared
    private let configuration: HybridCacheConfiguration
    
    public init(configuration: HybridCacheConfiguration = .default) {
        self.configuration = configuration
    }
    
    public func getEntity<T: DatabaseCacheable>(
        type: T.Type,
        primaryKey: String
    ) async -> T? {
        // Try memory cache first (fastest)
        if configuration.useMemoryCache {
            // Memory cache lookup would require cache key conversion
            // For now, skip memory cache for database entities
        }
        
        // Try database cache
        if configuration.useDatabaseCache {
            do {
                return try await databaseCache.getEntity(
                    type: type,
                    primaryKey: primaryKey,
                    configuration: configuration.databaseConfig
                )
            } catch {
                print("Database cache error: \(error)")
            }
        }
        
        return nil
    }
    
    public func storeEntity<T: DatabaseCacheable>(_ entity: T) async {
        // Store in database cache if enabled
        if configuration.useDatabaseCache {
            do {
                try await databaseCache.storeEntity(entity, configuration: configuration.databaseConfig)
            } catch {
                print("Failed to store entity in database: \(error)")
            }
        }
        
        // Note: Memory cache storage would require converting entity to Response<T>
        // which is complex for this use case
    }
    
    public func clearExpiredEntities() async -> Int {
        return await databaseCache.clearExpired()
    }
    
    public func clearAllEntities() async {
        await databaseCache.clear()
        await memoryCache.clear()
    }
}

public struct HybridCacheConfiguration: Sendable {
    public let useMemoryCache: Bool
    public let useDatabaseCache: Bool
    public let databaseConfig: DatabaseCacheConfiguration
    
    public init(
        useMemoryCache: Bool = false, // Memory cache not ideal for entities
        useDatabaseCache: Bool = true,
        databaseConfig: DatabaseCacheConfiguration = .longTerm
    ) {
        self.useMemoryCache = useMemoryCache
        self.useDatabaseCache = useDatabaseCache
        self.databaseConfig = databaseConfig
    }
    
    public static let `default` = HybridCacheConfiguration()
    public static let databaseOnly = HybridCacheConfiguration(useMemoryCache: false)
    public static let disabled = HybridCacheConfiguration(
        useMemoryCache: false,
        useDatabaseCache: false,
        databaseConfig: .disabled
    )
}