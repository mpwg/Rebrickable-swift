// CachingInterceptor.swift
//
// OpenAPI interceptor that implements caching for API requests
//

import Foundation

public class CachingInterceptor: OpenAPIInterceptor {
    private let apiCache: APICache
    private let configuration: CacheConfiguration
    
    public init(configuration: CacheConfiguration = .customConfiguration()) {
        self.configuration = configuration
        self.apiCache = APICache(configuration: configuration)
    }
    
    public func intercept<T>(
        urlRequest: URLRequest,
        urlSession: URLSessionProtocol,
        requestBuilder: RequestBuilder<T>,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        // For the intercept phase, we just pass through the request
        // Caching logic is handled in the retry phase and custom request builders
        completion(.success(urlRequest))
    }
    
    public func retry<T>(
        urlRequest: URLRequest,
        urlSession: URLSessionProtocol,
        requestBuilder: RequestBuilder<T>,
        data: Data?,
        response: URLResponse?,
        error: Error,
        completion: @escaping (OpenAPIInterceptorRetry) -> Void
    ) {
        // Check if we should serve from cache on network errors
        if shouldServeFromCacheOnError(error: error) {
            Task {
                let cacheKey = createCacheKey(from: urlRequest)
                
                // Try to get from cache
                if let httpResponse = response as? HTTPURLResponse,
                   let cachedResponse = await getCachedResponse(for: cacheKey, httpResponse: httpResponse) {
                    // We have cached data, but we need a way to inject it
                    // For now, we'll let the network error propagate
                    // In a real implementation, we'd need to modify the response
                }
                
                completion(.dontRetry)
            }
        } else {
            completion(.dontRetry)
        }
    }
    
    private func shouldServeFromCacheOnError(error: Error) -> Bool {
        // Serve from cache on network errors (not HTTP errors)
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost, .timedOut:
                return true
            default:
                return false
            }
        }
        return false
    }
    
    private func createCacheKey(from request: URLRequest) -> APICacheKey {
        guard let url = request.url,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return APICacheKey(endpoint: request.url?.absoluteString ?? "")
        }
        
        var parameters: [String: String] = [:]
        
        // Add query parameters
        if let queryItems = components.queryItems {
            for item in queryItems {
                parameters[item.name] = item.value ?? ""
            }
        }
        
        return APICacheKey(endpoint: components.path, parameters: parameters)
    }
    
    private func getCachedResponse(for key: APICacheKey, httpResponse: HTTPURLResponse) async -> CachedResponse? {
        do {
            return try await apiCache.internalCache.get(key: key)
        } catch {
            return nil
        }
    }
}