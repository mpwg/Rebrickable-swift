// CacheTests.swift
//
// Tests for the caching infrastructure
//

import XCTest
@testable import RebrickableLegoAPIClient

final class CacheTests: XCTestCase {
    
    func testMemoryCache() async throws {
        let cache = MemoryCache<APICacheKey, String>(maxSize: 3)
        let key1 = APICacheKey(endpoint: "/test1")
        let key2 = APICacheKey(endpoint: "/test2")
        
        // Test basic set/get
        try await cache.set(key: key1, value: "value1")
        let retrieved = try await cache.get(key: key1)
        XCTAssertEqual(retrieved, "value1")
        
        // Test cache miss
        let missing = try await cache.get(key: key2)
        XCTAssertNil(missing)
        
        // Test contains
        let contains = await cache.contains(key: key1)
        XCTAssertTrue(contains)
        
        let notContains = await cache.contains(key: key2)
        XCTAssertFalse(notContains)
    }
    
    func testCacheExpiration() async throws {
        let cache = MemoryCache<APICacheKey, String>(maxSize: 10)
        let key = APICacheKey(endpoint: "/test")
        
        // Set value with short expiration
        try await cache.set(key: key, value: "value", expiration: .after(0.1)) // 100ms
        
        // Should be available immediately
        let immediate = try await cache.get(key: key)
        XCTAssertEqual(immediate, "value")
        
        // Wait for expiration
        try await Task.sleep(nanoseconds: 200_000_000) // 200ms to ensure expiration
        
        // Should return nil for expired item (expired items are cleaned up automatically)
        let expiredResult = try await cache.get(key: key)
        XCTAssertNil(expiredResult, "Expected nil for expired cache item")
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
        XCTAssertNotNil(result1)
        XCTAssertNotNil(result2)
        
        // Add third item, should evict first (LRU)
        try await cache.set(key: key3, value: "value3")
        
        // First should be evicted
        let evictedResult = try await cache.get(key: key1)
        let result2After = try await cache.get(key: key2)
        let result3 = try await cache.get(key: key3)
        XCTAssertNil(evictedResult)
        XCTAssertNotNil(result2After)
        XCTAssertNotNil(result3)
    }
    
    func testCacheKey() {
        let key1 = APICacheKey(endpoint: "/test", parameters: ["param1": "value1", "param2": "value2"])
        let key2 = APICacheKey(endpoint: "/test", parameters: ["param2": "value2", "param1": "value1"])
        
        // Keys with same endpoint and parameters (in different order) should be equal
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.stringValue, key2.stringValue)
        
        let key3 = APICacheKey(endpoint: "/test", parameters: ["param1": "different"])
        XCTAssertNotEqual(key1, key3)
    }
    
    func testCacheConfiguration() {
        let config = CacheConfiguration.customConfiguration()
        
        // Test default configuration
        XCTAssertTrue(config.isEnabled)
        XCTAssertEqual(config.maxMemoryCacheSize, 200)
        
        // Test endpoint-specific configuration
        let colorsConfig = config.configurationFor(endpoint: "/api/v3/lego/colors/")
        XCTAssertTrue(colorsConfig.isEnabled)
        
        if case .after(let timeInterval) = colorsConfig.expiration {
            XCTAssertEqual(timeInterval, 3600) // 1 hour for colors
        } else {
            XCTFail("Expected .after expiration")
        }
        
        // Test unknown endpoint uses default
        let unknownConfig = config.configurationFor(endpoint: "/unknown/endpoint/")
        if case .after(let timeInterval) = unknownConfig.expiration {
            XCTAssertEqual(timeInterval, 600) // 10 minutes default
        } else {
            XCTFail("Expected .after expiration")
        }
    }
    
    func testCacheExpirationTypes() {
        // Test never expiration
        let neverExpires = CacheExpiration.never
        XCTAssertNil(neverExpires.expirationDate)
        XCTAssertFalse(neverExpires.isExpired())
        
        // Test after expiration
        let afterExpiration = CacheExpiration.after(10)
        XCTAssertNotNil(afterExpiration.expirationDate)
        XCTAssertFalse(afterExpiration.isExpired())
        
        // Test at expiration
        let pastDate = Date().addingTimeInterval(-10)
        let atExpiration = CacheExpiration.at(pastDate)
        XCTAssertTrue(atExpiration.isExpired())
        
        let futureDate = Date().addingTimeInterval(10)
        let futureExpiration = CacheExpiration.at(futureDate)
        XCTAssertFalse(futureExpiration.isExpired())
    }
    
    func testAPICacheKeyFromURL() {
        let urlString = "https://rebrickable.com/api/v3/lego/colors/?page=1&page_size=20"
        let key = APICacheKey.fromURL(urlString)
        
        XCTAssertEqual(key.endpoint, "/api/v3/lego/colors/")
        XCTAssertEqual(key.parameters["page"], "1")
        XCTAssertEqual(key.parameters["page_size"], "20")
        
        // Test with additional parameters
        let keyWithParams = APICacheKey.fromURL(urlString, parameters: ["custom": "value"])
        XCTAssertEqual(keyWithParams.parameters["custom"], "value")
        XCTAssertEqual(keyWithParams.parameters["page"], "1")
    }
}

// Mock classes for testing
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var taskIdentifier: Int = 1
    var progress: Progress = Progress()
    
    func resume() {
        // Mock implementation
    }
    
    func cancel() {
        // Mock implementation
    }
}

final class MockURLSession: URLSessionProtocol, @unchecked Sendable {
    func dataTaskFromProtocol(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTaskProtocol {
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