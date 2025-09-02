// CacheIntegrationTests.swift
//
// Integration tests for caching functionality
//

import Testing
import Foundation

@testable import RebrickableLegoAPIClient

final class CacheIntegrationTests {

    func testCacheConfigurationIntegration() {
        // Test that we can create cached configurations without errors
        let defaultConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching()
        #expect(defaultConfig.interceptor is CachingInterceptor)

        let productionConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
            cacheConfiguration: .production
        )
        #expect(productionConfig.interceptor is CachingInterceptor)

        let customConfig = RebrickableLegoAPIClientAPIConfiguration.withCaching(
            cacheConfiguration: CacheConfiguration(
                defaultExpiration: .after(300),
                maxMemoryCacheSize: 100
            )
        )
        #expect(customConfig.interceptor is CachingInterceptor)
    }

    func testEnableCachingOnSharedConfiguration() {
        let originalInterceptor = RebrickableLegoAPIClientAPIConfiguration.shared.interceptor

        // Enable caching
        RebrickableLegoAPIClientAPIConfiguration.shared.enableCaching()
        #expect(RebrickableLegoAPIClientAPIConfiguration.shared.interceptor is CachingInterceptor)

        // Restore original interceptor (in case other tests depend on it)
        RebrickableLegoAPIClientAPIConfiguration.shared.interceptor = originalInterceptor
    }

    func testCacheConfigurationTypes() {
        // Test all predefined configurations can be created
        let configs: [CacheConfiguration] = [
            .default,
            .aggressive,
            .conservative,
            .disabled,
            .development,
            .production,
            .customConfiguration(),
        ]

        for config in configs {
            #expect(config != nil)
        }

        // Test disabled configuration specifically
        let disabledConfig = CacheConfiguration.disabled
        #expect(!disabledConfig.isEnabled)
    }

    func testAPICacheSharedInstance() async {
        let cache = APICache.shared

        // Test basic cache operations
        let initialSize = await cache.cacheSize
        let _ = await cache.isEmpty

        // Cache should be empty initially (or at least respond to queries)
        #expect(initialSize >= 0)  // Size should be non-negative

        // Test clear operation
        await cache.clear()
        let sizeAfterClear = await cache.cacheSize
        let isEmptyAfterClear = await cache.isEmpty

        #expect(sizeAfterClear == 0)
        #expect(isEmptyAfterClear)
    }

    func testCacheKeyGeneration() {
        // Test that cache keys can be generated from various inputs
        let simpleKey = APICacheKey(endpoint: "/api/v3/lego/colors/")
        #expect(simpleKey.endpoint == "/api/v3/lego/colors/")
        #expect(simpleKey.parameters.isEmpty)

        let paramKey = APICacheKey(
            endpoint: "/api/v3/lego/parts/",
            parameters: ["page": "1", "page_size": "20"]
        )
        #expect(paramKey.endpoint == "/api/v3/lego/parts/")
        #expect(paramKey.parameters["page"] == "1")

        let urlKey = APICacheKey.fromURL("https://rebrickable.com/api/v3/lego/sets/?theme_id=1")
        #expect(urlKey.endpoint == "/api/v3/lego/sets/")
        #expect(urlKey.parameters["theme_id"] == "1")
    }

    func testCacheConfigurationEndpointSpecific() {
        let config = CacheConfiguration.customConfiguration()

        // Test that endpoint-specific configurations are applied
        let colorsConfig = config.configurationFor(endpoint: "/api/v3/lego/colors/")
        #expect(colorsConfig.isEnabled)

        if case .after(let timeInterval) = colorsConfig.expiration {
            #expect(timeInterval == 3600)  // Colors should be cached for 1 hour
        } else {
            Issue.record("Expected .after expiration for colors endpoint")
        }

        // Test unknown endpoint gets default configuration
        let unknownConfig = config.configurationFor(endpoint: "/unknown/endpoint/")
        if case .after(let timeInterval) = unknownConfig.expiration {
            #expect(timeInterval == 600)  // Default 10 minutes
        } else {
            Issue.record("Expected .after expiration for unknown endpoint")
        }
    }

    func testMemoryCacheWithDifferentTypes() async throws {
        // Test that memory cache works with different value types
        let stringCache = MemoryCache<APICacheKey, String>(maxSize: 10)
        let key = APICacheKey(endpoint: "/test")

        try await stringCache.set(key: key, value: "test_value")
        let retrievedString = try await stringCache.get(key: key)
        #expect(retrievedString == "test_value")

        // Test with dictionary type
        let dictCache = MemoryCache<APICacheKey, [String: String]>(maxSize: 10)
        let testDict = ["key1": "value1", "key2": "value2"]

        try await dictCache.set(key: key, value: testDict)
        let retrievedDict = try await dictCache.get(key: key)
        #expect(retrievedDict == testDict)
    }

    func testCacheExpirationPolicyVariations() {
        // Test different expiration policies
        let neverExpire = CacheExpiration.never
        #expect(neverExpire.expirationDate == nil)
        #expect(neverExpire.isExpired() == false)

        let afterDuration = CacheExpiration.after(300)
        #expect(afterDuration.expirationDate != nil)
        #expect(afterDuration.isExpired() == false)  // Should not be expired immediately

        let pastDate = Date().addingTimeInterval(-100)
        let expiredAt = CacheExpiration.at(pastDate)
        #expect(expiredAt.isExpired() == true)

        let futureDate = Date().addingTimeInterval(100)
        let notExpiredAt = CacheExpiration.at(futureDate)
        #expect(notExpiredAt.isExpired() == false)
    }

    func testCachingInterceptorCreation() {
        // Test that caching interceptor can be created with different configurations
        let defaultInterceptor = CachingInterceptor()
        #expect(defaultInterceptor != nil)

        let customInterceptor = CachingInterceptor(configuration: .production)
        #expect(customInterceptor != nil)

        let aggressiveInterceptor = CachingInterceptor(configuration: .aggressive)
        #expect(aggressiveInterceptor != nil)
    }
}
