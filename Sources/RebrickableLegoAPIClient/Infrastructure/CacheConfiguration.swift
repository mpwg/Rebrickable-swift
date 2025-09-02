// CacheConfiguration.swift
//
// Configuration for caching behavior in RebrickableLegoAPIClient
//

import Foundation

public struct CacheConfiguration: Sendable {
    public let isEnabled: Bool
    public let defaultExpiration: CacheExpiration
    public let maxMemoryCacheSize: Int
    public let endpointConfigurations: [String: EndpointCacheConfiguration]

    public init(
        isEnabled: Bool = true,
        defaultExpiration: CacheExpiration = .after(300), // 5 minutes default
        maxMemoryCacheSize: Int = 100,
        endpointConfigurations: [String: EndpointCacheConfiguration] = [:]
    ) {
        self.isEnabled = isEnabled
        self.defaultExpiration = defaultExpiration
        self.maxMemoryCacheSize = maxMemoryCacheSize
        self.endpointConfigurations = endpointConfigurations
    }

    public func configurationFor(endpoint: String) -> EndpointCacheConfiguration {
        endpointConfigurations[endpoint] ?? EndpointCacheConfiguration(
            isEnabled: isEnabled,
            expiration: defaultExpiration
        )
    }

    // Predefined configurations for common use cases
    public static let `default` = CacheConfiguration()

    public static let aggressive = CacheConfiguration(
        defaultExpiration: .after(1800), // 30 minutes
        maxMemoryCacheSize: 500
    )

    public static let conservative = CacheConfiguration(
        defaultExpiration: .after(60), // 1 minute
        maxMemoryCacheSize: 50
    )

    public static let disabled = CacheConfiguration(isEnabled: false)
}

public struct EndpointCacheConfiguration: Sendable {
    public let isEnabled: Bool
    public let expiration: CacheExpiration
    public let shouldCacheOnError: Bool

    public init(
        isEnabled: Bool = true,
        expiration: CacheExpiration = .after(300),
        shouldCacheOnError: Bool = false
    ) {
        self.isEnabled = isEnabled
        self.expiration = expiration
        self.shouldCacheOnError = shouldCacheOnError
    }
}

// Convenience configurations for different types of data
public extension CacheConfiguration {
    static func customConfiguration() -> CacheConfiguration {
        let endpointConfigs: [String: EndpointCacheConfiguration] = [
            // Colors change rarely, cache for longer
            "/api/v3/lego/colors/": EndpointCacheConfiguration(
                expiration: .after(3600) // 1 hour
            ),
            // Parts data is relatively stable
            "/api/v3/lego/parts/": EndpointCacheConfiguration(
                expiration: .after(1800) // 30 minutes
            ),
            // Themes are very stable
            "/api/v3/lego/themes/": EndpointCacheConfiguration(
                expiration: .after(7200) // 2 hours
            ),
            // Sets might change more frequently
            "/api/v3/lego/sets/": EndpointCacheConfiguration(
                expiration: .after(900) // 15 minutes
            ),
            // Part categories are stable
            "/api/v3/lego/part_categories/": EndpointCacheConfiguration(
                expiration: .after(3600) // 1 hour
            ),
        ]

        return CacheConfiguration(
            defaultExpiration: .after(600), // 10 minutes default
            maxMemoryCacheSize: 200,
            endpointConfigurations: endpointConfigs
        )
    }
}
