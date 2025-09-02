// CachedAPIConfiguration.swift
//
// Extensions to enable caching in RebrickableLegoAPIClient
//

import Foundation

public extension RebrickableLegoAPIClientAPIConfiguration {
    /// Creates a new configuration with caching enabled
    static func withCaching(
        cacheConfiguration: CacheConfiguration = .customConfiguration(),
        basePath: String = "https://rebrickable.com",
        apiKey: String? = nil
    ) -> RebrickableLegoAPIClientAPIConfiguration {
        let cachingInterceptor = CachingInterceptor(configuration: cacheConfiguration)
        
        return RebrickableLegoAPIClientAPIConfiguration(
            basePath: basePath,
            apiKey: apiKey,
            requestBuilderFactory: CachedRequestBuilderFactory(cacheConfiguration: cacheConfiguration),
            interceptor: cachingInterceptor
        )
    }
    
    /// Enable caching on the current configuration
    func enableCaching(
        with cacheConfiguration: CacheConfiguration = .customConfiguration()
    ) {
        let cachingInterceptor = CachingInterceptor(configuration: cacheConfiguration)
        self.interceptor = cachingInterceptor
        self.requestBuilderFactory = CachedRequestBuilderFactory(cacheConfiguration: cacheConfiguration)
    }
}

// Enhanced cached request builder factory
public class CachedRequestBuilderFactory: RequestBuilderFactory {
    private let cacheConfiguration: CacheConfiguration
    private let apiCache: APICache
    
    public init(cacheConfiguration: CacheConfiguration = .customConfiguration()) {
        self.cacheConfiguration = cacheConfiguration
        self.apiCache = APICache(configuration: cacheConfiguration)
    }
    
    public func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        // Non-decodable builders don't support caching
        URLSessionRequestBuilder<T>.self
    }
    
    public func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type {
        // Return the cached builder for decodable types
        CachedDecodableRequestBuilder<T>.self
    }
}

// Improved cached request builder that integrates with the API cache
open class CachedDecodableRequestBuilder<T: Decodable & Sendable>: URLSessionDecodableRequestBuilder<T> {
    private static var apiCache: APICache {
        APICache.shared
    }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    override open func execute() async throws(ErrorResponse) -> Response<T> {
        let cacheKey = createCacheKey()
        
        // Try to get from cache first (only for GET requests)
        if method.uppercased() == "GET" {
            if let cachedResponse = await Self.apiCache.getCachedResponse(
                for: cacheKey,
                type: T.self,
                codableHelper: apiConfiguration.codableHelper
            ) {
                return cachedResponse
            }
        }
        
        // Execute network request
        let response = try await super.execute()
        
        // Cache successful responses (only for GET requests)
        if method.uppercased() == "GET" {
            await Self.apiCache.cacheResponse(response, for: cacheKey)
        }
        
        return response
    }
    
    private func createCacheKey() -> APICacheKey {
        guard let url = URL(string: URLString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return APICacheKey(endpoint: URLString)
        }
        
        var parameters: [String: String] = [:]
        
        // Add query parameters
        if let queryItems = components.queryItems {
            for item in queryItems {
                parameters[item.name] = item.value ?? ""
            }
        }
        
        // Add relevant headers that affect response
        let relevantHeaders = ["Accept-Language", "Accept"]
        for header in relevantHeaders {
            if let value = headers[header] {
                parameters["_header_\(header)"] = value
            }
        }
        
        return APICacheKey(endpoint: components.path, parameters: parameters)
    }
}