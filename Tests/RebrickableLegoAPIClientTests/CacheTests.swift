// CacheTests.swift
//
// Tests for the caching infrastructure
//

import Foundation
import Testing

@testable import RebrickableLegoAPIClient

final class CacheTests {
    func testMemoryCache() async throws {
        let cache = MemoryCache<APICacheKey, String>(maxSize: 3)
        let key1 = APICacheKey(endpoint: "/test1")
        let key2 = APICacheKey(endpoint: "/test2")

        // Test basic set/get
        try await cache.set(key: key1, value: "value1")
        let retrieved = try await cache.get(key: key1)
        #expect(retrieved == "value1")

        // Test cache miss
        let missing = try await cache.get(key: key2)
        #expect(missing == nil)

        // Test contains
        let contains = await cache.contains(key: key1)
        #expect(contains == true)

        let notContains = await cache.contains(key: key2)
        #expect(notContains == false)
    }

    func testCacheExpiration() async throws {
        let cache = MemoryCache<APICacheKey, String>(maxSize: 10)
        let key = APICacheKey(endpoint: "/test")

        // Set value with short expiration
        try await cache.set(key: key, value: "value", expiration: .after(0.1)) // 100ms

        // Should be available immediately
        let immediate = try await cache.get(key: key)
        #expect(immediate == "value")

        // Wait for expiration
        try await Task.sleep(nanoseconds: 200_000_000) // 200ms to ensure expiration

        // Should return nil for expired item (expired items are cleaned up automatically)
        let expiredResult = try await cache.get(key: key)
        #expect(expiredResult == nil)
    }

    func testCacheLRUEviction() async throws {
        let cache = MemoryCache<APICacheKey, String>(maxSize: 2)

        let key1 = APICacheKey(endpoint: "/test1")
        let key2 = APICacheKey(endpoint: "/test2")
        let key3 = APICacheKey(endpoint: "/test3")

        // Fill cache to capacity
        try await cache.set(key: key1, value: "value1")
        try await cache.set(key: key2, value: "value2")

        // Both should be available
        let result1 = try await cache.get(key: key1)
        let result2 = try await cache.get(key: key2)
        #expect(result1 != nil)
        #expect(result2 != nil)

        // Add third item, should evict first (LRU)
        try await cache.set(key: key3, value: "value3")

        // First should be evicted
        let evictedResult = try await cache.get(key: key1)
        let result2After = try await cache.get(key: key2)
        let result3 = try await cache.get(key: key3)
        #expect(evictedResult == nil)
        #expect(result2After != nil)
        #expect(result3 != nil)
    }

    func testCacheKey() {
        let key1 = APICacheKey(
            endpoint: "/test", parameters: ["param1": "value1", "param2": "value2"]
        )
        let key2 = APICacheKey(
            endpoint: "/test", parameters: ["param2": "value2", "param1": "value1"]
        )

        // Keys with same endpoint and parameters (in different order) should be equal
        #expect(key1 == key2)
        #expect(key1.stringValue == key2.stringValue)

        let key3 = APICacheKey(endpoint: "/test", parameters: ["param1": "different"])
        #expect(key1 != key3)
    }

    func testCacheConfiguration() {
        let config = CacheConfiguration.customConfiguration()

        // Test default configuration
        #expect(config.isEnabled == true)
        #expect(config.maxMemoryCacheSize == 200)

        // Test endpoint-specific configuration
        let colorsConfig = config.configurationFor(endpoint: "/api/v3/lego/colors/")
        #expect(colorsConfig.isEnabled == true)

        if case let .after(timeInterval) = colorsConfig.expiration {
            #expect(timeInterval == 3600) // 1 hour for colors
        } else {
            Issue.record("Expected .after expiration")
        }

        // Test unknown endpoint uses default
        let unknownConfig = config.configurationFor(endpoint: "/unknown/endpoint/")
        if case let .after(timeInterval) = unknownConfig.expiration {
            #expect(timeInterval == 600) // 10 minutes default
        } else {
            Issue.record("Expected .after expiration")
        }
    }

    func testCacheExpirationTypes() {
        // Test never expiration
        let neverExpires = CacheExpiration.never
        #expect(neverExpires.expirationDate == nil)
        #expect(neverExpires.isExpired() == false)

        // Test after expiration
        let afterExpiration = CacheExpiration.after(10)
        #expect(afterExpiration.expirationDate != nil)
        #expect(afterExpiration.isExpired() == false)

        // Test at expiration
        let pastDate = Date().addingTimeInterval(-10)
        let atExpiration = CacheExpiration.at(pastDate)
        #expect(atExpiration.isExpired() == true)

        let futureDate = Date().addingTimeInterval(10)
        let futureExpiration = CacheExpiration.at(futureDate)
        #expect(futureExpiration.isExpired() == false)
    }

    func testAPICacheKeyFromURL() {
        let urlString = "https://rebrickable.com/api/v3/lego/colors/?page=1&page_size=20"
        let key = APICacheKey.fromURL(urlString)

        #expect(key.endpoint == "/api/v3/lego/colors/")
        #expect(key.parameters["page"] == "1")
        #expect(key.parameters["page_size"] == "20")

        // Test with additional parameters
        let keyWithParams = APICacheKey.fromURL(urlString, parameters: ["custom": "value"])
        #expect(keyWithParams.parameters["custom"] == "value")
        #expect(keyWithParams.parameters["page"] == "1")
    }
}

// Mock classes for testing
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var taskIdentifier: Int = 1
    var progress: Progress = .init()

    func resume() {
        // Mock implementation
    }

    func cancel() {
        // Mock implementation
    }
}

final class MockURLSession: URLSessionProtocol, @unchecked Sendable {
    func dataTaskFromProtocol(
        with request: URLRequest,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionDataTaskProtocol {
        // Mock implementation - return success with empty data
        DispatchQueue.global().async {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: "1.1",
                headerFields: ["Content-Type": "application/json"]
            )
            completionHandler(Data(), response, nil)
        }
        return MockURLSessionDataTask()
    }
}
