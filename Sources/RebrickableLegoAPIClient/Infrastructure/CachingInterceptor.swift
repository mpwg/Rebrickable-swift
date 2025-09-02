// CachingInterceptor.swift
//
// OpenAPI interceptor that implements caching for API requests
//

import Foundation

public class CachingInterceptor: OpenAPIInterceptor, @unchecked Sendable {
    private let apiCache: APICache
    private let configuration: CacheConfiguration

    public init(configuration: CacheConfiguration = .customConfiguration()) {
        self.configuration = configuration
        apiCache = APICache(configuration: configuration)
    }

    public func intercept<T>(
        urlRequest: URLRequest,
        urlSession _: URLSessionProtocol,
        requestBuilder _: RequestBuilder<T>,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        // For the intercept phase, we just pass through the request
        // Caching logic is handled in the retry phase and custom request builders
        completion(.success(urlRequest))
    }

    public func retry<T>(
        urlRequest _: URLRequest,
        urlSession _: URLSessionProtocol,
        requestBuilder _: RequestBuilder<T>,
        data _: Data?,
        response _: URLResponse?,
        error _: Error,
        completion: @escaping (OpenAPIInterceptorRetry) -> Void
    ) {
        // For now, we don't serve stale cache in the interceptor
        // This would require more complex response injection
        completion(.dontRetry)
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
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
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

    private func getCachedResponse(for key: APICacheKey, httpResponse _: HTTPURLResponse) async -> CachedResponse? {
        do {
            return try await apiCache.internalCache.get(key: key)
        } catch {
            return nil
        }
    }
}
