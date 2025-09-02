// DatabaseCacheableModels.swift
//
// Extensions to make LEGO models cacheable in database
//

import Foundation

// MARK: - Color

extension Color: DatabaseCacheable {
    public var primaryKey: String {
        return "\(id ?? -1)"
    }

    public static var tableName: String {
        return "colors"
    }
}

// MARK: - Element

extension Element: DatabaseCacheable {
    public var primaryKey: String {
        return elementId ?? ""
    }

    public static var tableName: String {
        return "elements"
    }
}

// MARK: - Part

extension Part: DatabaseCacheable {
    public var primaryKey: String {
        return partNum ?? ""
    }

    public static var tableName: String {
        return "parts"
    }
}

// MARK: - PartColor

extension PartColor: DatabaseCacheable {
    public var primaryKey: String {
        // For PartColor, we need both part number and color ID for uniqueness
        // Since partNum is not in the response, we'll use a special format
        // The DatabaseCachedRequestBuilder will extract both from the URL
        return "\(colorId ?? -1)"  // Default to colorId, but URL extraction will provide full key
    }

    public static var tableName: String {
        return "part_colors"
    }
}

// MARK: - Theme

extension Theme: DatabaseCacheable {
    public var primaryKey: String {
        return "\(id)"
    }

    public static var tableName: String {
        return "themes"
    }
}

// MARK: - PartCategory

extension PartCategory: DatabaseCacheable {
    public var primaryKey: String {
        guard let id = id else {
            fatalError("PartCategory must have a valid id to generate a cache key.")
        }
        return "\(id)"
    }

    public static var tableName: String {
        return "part_categories"
    }
}

// MARK: - ModelSet (Sets and Minifigs)

extension ModelSet: DatabaseCacheable {
    public var primaryKey: String {
        return setNum ?? ""
    }

    public static var tableName: String {
        return "sets"
    }
}

// MARK: - Database Cache Configuration

public struct DatabaseCacheConfiguration: Sendable {
    public let isEnabled: Bool
    public let defaultExpiration: CacheExpiration
    public let entityConfigurations: [String: EntityDatabaseConfiguration]

    public init(
        isEnabled: Bool = true,
        defaultExpiration: CacheExpiration = .after(24 * 60 * 60),  // 24 hours for database cache
        entityConfigurations: [String: EntityDatabaseConfiguration] = [:]
    ) {
        self.isEnabled = isEnabled
        self.defaultExpiration = defaultExpiration
        self.entityConfigurations = entityConfigurations
    }

    public func configurationFor(entityType: String) -> EntityDatabaseConfiguration {
        entityConfigurations[entityType]
            ?? EntityDatabaseConfiguration(
                isEnabled: isEnabled,
                expiration: defaultExpiration
            )
    }

    // Predefined configurations
    public static let `default` = DatabaseCacheConfiguration()

    public static let longTerm = DatabaseCacheConfiguration(
        defaultExpiration: .after(604800),  // 7 days
        entityConfigurations: [
            "colors": EntityDatabaseConfiguration(expiration: .never),  // Colors rarely change
            "themes": EntityDatabaseConfiguration(expiration: .after(2_592_000)),  // 30 days
            "part_categories": EntityDatabaseConfiguration(expiration: .after(2_592_000)),  // 30 days
            "parts": EntityDatabaseConfiguration(expiration: .after(604800)),  // 7 days
            "elements": EntityDatabaseConfiguration(expiration: .after(604800)),  // 7 days
            "sets": EntityDatabaseConfiguration(expiration: .after(86400)),  // 1 day (includes minifigs)
        ]
    )

    public static let shortTerm = DatabaseCacheConfiguration(
        defaultExpiration: .after(3600),  // 1 hour
        entityConfigurations: [
            "colors": EntityDatabaseConfiguration(expiration: .after(86400)),  // 1 day
            "themes": EntityDatabaseConfiguration(expiration: .after(43200)),  // 12 hours
            "part_categories": EntityDatabaseConfiguration(expiration: .after(43200)),  // 12 hours
            "parts": EntityDatabaseConfiguration(expiration: .after(7200)),  // 2 hours
            "elements": EntityDatabaseConfiguration(expiration: .after(7200)),  // 2 hours
            "sets": EntityDatabaseConfiguration(expiration: .after(3600)),  // 1 hour (includes minifigs)
        ]
    )

    public static let disabled = DatabaseCacheConfiguration(isEnabled: false)
}

public struct EntityDatabaseConfiguration: Sendable {
    public let isEnabled: Bool
    public let expiration: CacheExpiration
    public let shouldCacheOnError: Bool

    public init(
        isEnabled: Bool = true,
        expiration: CacheExpiration = .after(86400),
        shouldCacheOnError: Bool = true
    ) {
        self.isEnabled = isEnabled
        self.expiration = expiration
        self.shouldCacheOnError = shouldCacheOnError
    }
}

// MARK: - Helper Functions

extension DatabaseCache {

    /// Store a single entity with automatic expiration based on type
    public func storeEntity<T: DatabaseCacheable>(
        _ entity: T,
        configuration: DatabaseCacheConfiguration = .longTerm
    ) async throws {
        guard configuration.isEnabled else { return }

        let entityConfig = configuration.configurationFor(entityType: T.tableName)
        guard entityConfig.isEnabled else { return }

        try await store(entity: entity, expiration: entityConfig.expiration)
    }

    /// Retrieve a single entity by its primary key
    public func getEntity<T: DatabaseCacheable>(
        type: T.Type,
        primaryKey: String,
        configuration: DatabaseCacheConfiguration = .longTerm
    ) async throws -> T? {
        guard configuration.isEnabled else { return nil }

        let entityConfig = configuration.configurationFor(entityType: T.tableName)
        guard entityConfig.isEnabled else { return nil }

        return try await retrieve(type: type, primaryKey: primaryKey)
    }

    /// Remove a single entity by its primary key
    public func removeEntity<T: DatabaseCacheable>(
        type: T.Type,
        primaryKey: String
    ) async {
        await withCheckedContinuation { continuation in
            remove(type: type, primaryKey: primaryKey) { _ in
                continuation.resume()
            }
        }
    }
}
