// CacheUsageExample.swift
//
// Examples of how to use the caching infrastructure
//

import Foundation

public class CacheUsageExamples {
    
    // MARK: - Basic Usage
    
    /// Example 1: Using the shared API configuration with default caching
    public static func basicCachingExample() async throws {
        // Enable caching on the shared configuration
        RebrickableLegoAPIClientAPIConfiguration.shared.enableCaching()
        
        // Now all API calls will use caching automatically
        let colorsList = try await LegoAPI.legoColorsList()
        print("Fetched \(colorsList.count ?? 0) colors")
        
        // Second call will return from cache if within expiration time
        let cachedColorsList = try await LegoAPI.legoColorsList()
        print("Second call fetched \(cachedColorsList.count ?? 0) colors (likely from cache)")
    }
    
    /// Example 2: Using a custom configuration with aggressive caching
    public static func customCachingExample() async throws {
        // Create a configuration with aggressive caching
        let cachedConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
            cacheConfiguration: .aggressive,
            apiKey: "your-api-key"
        )
        
        // Use the configuration for API calls
        let parts = try await LegoAPI.legoPartsList(apiConfiguration: cachedConfig)
        print("Fetched \(parts.count ?? 0) parts")
    }
    
    /// Example 3: Custom cache configuration
    public static func advancedCachingExample() async throws {
        // Create custom endpoint configurations
        let endpointConfigs: [String: EndpointCacheConfiguration] = [
            "/api/v3/lego/colors/": EndpointCacheConfiguration(
                expiration: .after(3600) // Cache colors for 1 hour
            ),
            "/api/v3/lego/parts/": EndpointCacheConfiguration(
                expiration: .after(900) // Cache parts for 15 minutes
            )
        ]
        
        let customCacheConfig = CacheConfiguration(
            defaultExpiration: .after(300), // 5 minutes default
            maxMemoryCacheSize: 500,
            endpointConfigurations: endpointConfigs
        )
        
        let apiConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
            cacheConfiguration: customCacheConfig,
            apiKey: "your-api-key"
        )
        
        // Use the custom configuration
        let themes = try await LegoAPI.legoThemesList(apiConfiguration: apiConfig)
        print("Fetched \(themes.count ?? 0) themes")
    }
    
    // MARK: - Cache Management
    
    /// Example 4: Manual cache management
    public static func cacheManagementExample() async {
        let apiCache = APICache.shared
        
        // Check cache size
        let size = await apiCache.cacheSize
        print("Cache contains \(size) items")
        
        // Clear specific cache entry
        let cacheKey = APICacheKey(endpoint: "/api/v3/lego/colors/")
        await apiCache.remove(key: cacheKey)
        
        // Clear entire cache
        await apiCache.clear()
        
        print("Cache cleared")
    }
    
    /// Example 5: Cache with different expiration policies
    public static func expirationPolicyExample() async throws {
        // Cache that never expires
        let neverExpireConfig = CacheConfiguration(
            defaultExpiration: .never
        )
        
        // Cache that expires at specific time
        let specificTimeConfig = CacheConfiguration(
            defaultExpiration: .at(Date().addingTimeInterval(3600)) // Expires in 1 hour
        )
        
        // Cache with short expiration for testing
        let shortExpirationConfig = CacheConfiguration(
            defaultExpiration: .after(10) // Expires in 10 seconds
        )
        
        let testConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
            cacheConfiguration: shortExpirationConfig
        )
        
        // First call fetches from network
        _ = try await LegoAPI.legoColorsList(apiConfiguration: testConfig)
        
        // Immediate second call returns from cache
        _ = try await LegoAPI.legoColorsList(apiConfiguration: testConfig)
        
        // Wait for expiration
        try await Task.sleep(nanoseconds: 11_000_000_000) // 11 seconds
        
        // This call will fetch from network again
        _ = try await LegoAPI.legoColorsList(apiConfiguration: testConfig)
    }
    
    // MARK: - Error Handling with Cache
    
    /// Example 6: Handling network errors with cached fallback
    public static func errorHandlingExample() async throws {
        // Configure cache to serve stale data on network errors
        let errorTolerantConfig = CacheConfiguration(
            defaultExpiration: .after(300),
            endpointConfigurations: [
                "/api/v3/lego/colors/": EndpointCacheConfiguration(
                    expiration: .after(1800),
                    shouldCacheOnError: true // Allow serving stale cache on errors
                )
            ]
        )
        
        let apiConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
            cacheConfiguration: errorTolerantConfig
        )
        
        do {
            // This will fetch and cache data
            let colors = try await LegoAPI.legoColorsList(apiConfiguration: apiConfig)
            print("Successfully fetched \(colors.count ?? 0) colors")
            
            // If network fails later, cached data might be served
            // (implementation depends on error type)
        } catch {
            print("Network error occurred: \(error)")
            // Cached data might be served automatically if configured
        }
    }
}

// MARK: - Utility Functions

public extension CacheConfiguration {
    /// Create a development-friendly configuration with short expiration times
    static var development: CacheConfiguration {
        CacheConfiguration(
            defaultExpiration: .after(30), // 30 seconds for quick testing
            maxMemoryCacheSize: 50
        )
    }
    
    /// Create a production configuration optimized for LEGO data
    static var production: CacheConfiguration {
        let endpointConfigs: [String: EndpointCacheConfiguration] = [
            // Static data can be cached longer
            "/api/v3/lego/colors/": EndpointCacheConfiguration(expiration: .after(86400)), // 24 hours
            "/api/v3/lego/themes/": EndpointCacheConfiguration(expiration: .after(43200)), // 12 hours
            "/api/v3/lego/part_categories/": EndpointCacheConfiguration(expiration: .after(43200)), // 12 hours
            
            // Semi-static data
            "/api/v3/lego/parts/": EndpointCacheConfiguration(expiration: .after(7200)), // 2 hours
            
            // More dynamic data
            "/api/v3/lego/sets/": EndpointCacheConfiguration(expiration: .after(1800)), // 30 minutes
            "/api/v3/lego/minifigs/": EndpointCacheConfiguration(expiration: .after(1800)) // 30 minutes
        ]
        
        return CacheConfiguration(
            defaultExpiration: .after(900), // 15 minutes default
            maxMemoryCacheSize: 1000,
            endpointConfigurations: endpointConfigs
        )
    }
}