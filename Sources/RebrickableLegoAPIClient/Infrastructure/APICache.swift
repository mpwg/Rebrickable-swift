// APICache.swift
//
// Main cache manager for RebrickableLegoAPIClient
//

import Foundation

public final class APICache: @unchecked Sendable {
    public static let shared = APICache()

    private let _memoryCache: MemoryCache<APICacheKey, CachedResponse>
    private let configuration: CacheConfiguration
    private let queue = DispatchQueue(label: "com.rebrickable.api.cache", attributes: .concurrent)

    public init(configuration: CacheConfiguration = .customConfiguration()) {
        self.configuration = configuration
        _memoryCache = MemoryCache<APICacheKey, CachedResponse>(
            maxSize: configuration.maxMemoryCacheSize
        )
    }

    // Generic method to cache any Decodable response
    public func cacheResponse<T: Decodable & Sendable>(
        _ response: Response<T>,
        for key: APICacheKey,
        expiration: CacheExpiration? = nil
    ) async {
        guard configuration.isEnabled else { return }

        let cachedResponse = CachedResponse(
            data: response.bodyData,
            statusCode: response.statusCode,
            headers: response.header,
            createdAt: Date()
        )

        let effectiveExpiration = expiration ?? configuration.configurationFor(endpoint: key.endpoint).expiration

        do {
            try await _memoryCache.set(key: key, value: cachedResponse, expiration: effectiveExpiration)
        } catch {
            print("Failed to cache response: \(error)")
        }
    }

    // Generic method to retrieve and decode cached response
    public func getCachedResponse<T: Decodable>(
        for key: APICacheKey,
        type _: T.Type,
        codableHelper: CodableHelper
    ) async -> Response<T>? {
        guard configuration.isEnabled else { return nil }

        do {
            guard let cachedResponse = try await _memoryCache.get(key: key) else {
                return nil
            }

            // Decode the cached data
            guard let data = cachedResponse.data else {
                return nil
            }

            let decodeResult = codableHelper.decode(T.self, from: data)
            switch decodeResult {
            case let .success(decodedObject):
                return Response(
                    statusCode: cachedResponse.statusCode,
                    header: cachedResponse.headers,
                    body: decodedObject,
                    bodyData: data
                )
            case .failure:
                // Remove invalid cached data
                try await _memoryCache.remove(key: key)
                return nil
            }
        } catch CacheError.expired {
            return nil
        } catch {
            print("Cache retrieval error: \(error)")
            return nil
        }
    }

    public func clear() async {
        do {
            try await _memoryCache.clear()
        } catch {
            print("Failed to clear cache: \(error)")
        }
    }

    public func remove(key: APICacheKey) async {
        do {
            try await _memoryCache.remove(key: key)
        } catch {
            print("Failed to remove cached item: \(error)")
        }
    }

    public var cacheSize: Int {
        get async {
            await _memoryCache.count
        }
    }

    public var isEmpty: Bool {
        get async {
            await _memoryCache.isEmpty
        }
    }
}

// Helper structure to store cached HTTP responses
struct CachedResponse: Sendable {
    let data: Data?
    let statusCode: Int
    let headers: [String: String]
    let createdAt: Date

    init(data: Data?, statusCode: Int, headers: [String: String], createdAt: Date = Date()) {
        self.data = data
        self.statusCode = statusCode
        self.headers = headers
        self.createdAt = createdAt
    }
}

// Extension to create cache keys from URL components
public extension APICacheKey {
    static func fromURL(_ urlString: String, parameters: [String: any Sendable]? = nil) -> APICacheKey {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            return APICacheKey(endpoint: urlString)
        }

        var allParameters: [String: String] = [:]

        // Add query parameters from URL
        if let queryItems = components.queryItems {
            for item in queryItems {
                allParameters[item.name] = item.value ?? ""
            }
        }

        // Add additional parameters
        if let params = parameters {
            for (key, value) in params {
                allParameters[key] = "\(value)"
            }
        }

        return APICacheKey(endpoint: components.path, parameters: allParameters)
    }
}

// Extension to APICache to expose memory cache for interceptor
extension APICache {
    var internalCache: MemoryCache<APICacheKey, CachedResponse> {
        _memoryCache
    }
}
