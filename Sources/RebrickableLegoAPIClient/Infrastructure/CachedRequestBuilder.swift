// CachedRequestBuilder.swift
//
// Request builder with caching capabilities for RebrickableLegoAPIClient
//

import Foundation

open class CachedURLSessionDecodableRequestBuilder<T: Decodable & Sendable>: URLSessionDecodableRequestBuilder<T>, @unchecked Sendable {
    private let cache: MemoryCache<APICacheKey, Response<T>>
    private let cacheConfiguration: CacheConfiguration
    
    public init(
        method: String,
        URLString: String,
        parameters: [String: any Sendable]?,
        headers: [String: String] = [:],
        requiresAuthentication: Bool,
        apiConfiguration: RebrickableLegoAPIClientAPIConfiguration = RebrickableLegoAPIClientAPIConfiguration.shared,
        cache: MemoryCache<APICacheKey, Response<T>>,
        cacheConfiguration: CacheConfiguration
    ) {
        self.cache = cache
        self.cacheConfiguration = cacheConfiguration
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
        // Use default cache and configuration when using required initializer
        self.cache = MemoryCache<APICacheKey, Response<T>>(maxSize: 100)
        self.cacheConfiguration = .default
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
        // Check if caching is disabled
        guard cacheConfiguration.isEnabled else {
            return try await super.execute()
        }
        
        let cacheKey = createCacheKey()
        let endpointConfig = getEndpointConfiguration()
        
        // Check if caching is disabled for this endpoint
        guard endpointConfig.isEnabled else {
            return try await super.execute()
        }
        
        // Try to get from cache first (only for GET requests)
        if method.uppercased() == "GET" {
            do {
                if let cachedResponse = try await cache.get(key: cacheKey) {
                    return cachedResponse
                }
            } catch CacheError.expired {
                // Cache expired, proceed with network request
            } catch {
                // Other cache errors, log but continue with network request
                print("Cache error: \(error)")
            }
        }
        
        // Execute network request
        do {
            let response = try await super.execute()
            
            // Cache successful responses (only for GET requests)
            if method.uppercased() == "GET" {
                await cacheResponse(response, key: cacheKey, config: endpointConfig)
            }
            
            return response
        } catch let error {
            // For certain errors, we might want to return cached data if available
            if shouldUseCacheOnError(error: error, config: endpointConfig) {
                do {
                    if let cachedResponse = try await cache.get(key: cacheKey) {
                        return cachedResponse
                    }
                } catch {
                    // Cache miss or error, rethrow original error
                }
            }
            throw error
        }
    }
    
    private func createCacheKey() -> APICacheKey {
        guard let url = URL(string: URLString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return APICacheKey(endpoint: URLString)
        }
        
        let endpoint = components.path
        var parameters: [String: String] = [:]
        
        // Add query parameters
        if let queryItems = components.queryItems {
            for item in queryItems {
                parameters[item.name] = item.value ?? ""
            }
        }
        
        // Add relevant headers that affect response (e.g., Accept-Language)
        let relevantHeaders = ["Accept-Language", "Accept"]
        for header in relevantHeaders {
            if let value = headers[header] {
                parameters["_header_\(header)"] = value
            }
        }
        
        return APICacheKey(endpoint: endpoint, parameters: parameters)
    }
    
    private func getEndpointConfiguration() -> EndpointCacheConfiguration {
        guard let url = URL(string: URLString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return EndpointCacheConfiguration()
        }
        
        return cacheConfiguration.configurationFor(endpoint: components.path)
    }
    
    private func cacheResponse(
        _ response: Response<T>,
        key: APICacheKey,
        config: EndpointCacheConfiguration
    ) async {
        do {
            try await cache.set(key: key, value: response, expiration: config.expiration)
        } catch {
            print("Failed to cache response: \(error)")
        }
    }
    
    private func shouldUseCacheOnError(
        error: ErrorResponse,
        config: EndpointCacheConfiguration
    ) -> Bool {
        // Only use cache on network errors, not on HTTP errors like 404, 401, etc.
        // ErrorResponse.error(statusCode, data, response, error) - negative status codes indicate network errors
        if case .error(let statusCode, _, _, _) = error {
            return config.shouldCacheOnError && statusCode < 0
        }
        return false
    }
}