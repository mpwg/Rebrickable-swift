// DatabaseCacheConfiguration.swift
//
// Configuration extensions for database caching integration
//

import Foundation

// Enhanced cache configuration that combines memory and database caching
public struct CombinedCacheConfiguration: Sendable {
    public let memoryCache: CacheConfiguration
    public let databaseCache: DatabaseCacheConfiguration
    public let useDatabaseForSingleEntities: Bool
    
    public init(
        memoryCache: CacheConfiguration = .default,
        databaseCache: DatabaseCacheConfiguration = .longTerm,
        useDatabaseForSingleEntities: Bool = true
    ) {
        self.memoryCache = memoryCache
        self.databaseCache = databaseCache
        self.useDatabaseForSingleEntities = useDatabaseForSingleEntities
    }
    
    // Predefined combined configurations
    public static let `default` = CombinedCacheConfiguration()
    
    public static let performance = CombinedCacheConfiguration(
        memoryCache: .aggressive,
        databaseCache: .longTerm,
        useDatabaseForSingleEntities: true
    )
    
    public static let storage = CombinedCacheConfiguration(
        memoryCache: .conservative,
        databaseCache: .longTerm,
        useDatabaseForSingleEntities: true
    )
    
    public static let memoryOnly = CombinedCacheConfiguration(
        memoryCache: .default,
        databaseCache: .disabled,
        useDatabaseForSingleEntities: false
    )
    
    public static let databaseOnly = CombinedCacheConfiguration(
        memoryCache: .disabled,
        databaseCache: .longTerm,
        useDatabaseForSingleEntities: true
    )
    
    public static let disabled = CombinedCacheConfiguration(
        memoryCache: .disabled,
        databaseCache: .disabled,
        useDatabaseForSingleEntities: false
    )
}

// Request builder factory that supports database caching
public class DatabaseAwareRequestBuilderFactory: RequestBuilderFactory {
    private let databaseConfig: DatabaseCacheConfiguration
    
    public init(databaseConfig: DatabaseCacheConfiguration = .longTerm) {
        self.databaseConfig = databaseConfig
    }
    
    public func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        URLSessionRequestBuilder<T>.self
    }
    
    public func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type {
        // Return standard builder - the system will create the appropriate builder at runtime
        URLSessionDecodableRequestBuilder<T>.self
    }
}

// Extensions to add database caching to API configurations
public extension RebrickableLegoAPIClientAPIConfiguration {
    
    /// Create configuration with database caching for single entities
    static func withDatabaseCaching(
        databaseConfig: DatabaseCacheConfiguration = .longTerm,
        basePath: String = "https://rebrickable.com",
        apiKey: String? = nil
    ) -> RebrickableLegoAPIClientAPIConfiguration {
        return RebrickableLegoAPIClientAPIConfiguration(
            basePath: basePath,
            apiKey: apiKey,
            requestBuilderFactory: DatabaseAwareRequestBuilderFactory(databaseConfig: databaseConfig)
        )
    }
    
    /// Create configuration with both memory and database caching
    static func withCombinedCaching(
        combinedConfig: CombinedCacheConfiguration = .default,
        basePath: String = "https://rebrickable.com",
        apiKey: String? = nil
    ) -> RebrickableLegoAPIClientAPIConfiguration {
        let cachingInterceptor = CachingInterceptor(configuration: combinedConfig.memoryCache)
        
        return RebrickableLegoAPIClientAPIConfiguration(
            basePath: basePath,
            apiKey: apiKey,
            requestBuilderFactory: combinedConfig.useDatabaseForSingleEntities ?
                DatabaseAwareRequestBuilderFactory(databaseConfig: combinedConfig.databaseCache) :
                CachedRequestBuilderFactory(cacheConfiguration: combinedConfig.memoryCache),
            interceptor: cachingInterceptor
        )
    }
    
    /// Enable database caching on existing configuration
    func enableDatabaseCaching(
        with databaseConfig: DatabaseCacheConfiguration = .longTerm
    ) {
        self.requestBuilderFactory = DatabaseAwareRequestBuilderFactory(databaseConfig: databaseConfig)
    }
    
    /// Enable combined memory and database caching
    func enableCombinedCaching(
        with combinedConfig: CombinedCacheConfiguration = .default
    ) {
        let cachingInterceptor = CachingInterceptor(configuration: combinedConfig.memoryCache)
        
        self.interceptor = cachingInterceptor
        self.requestBuilderFactory = combinedConfig.useDatabaseForSingleEntities ?
            DatabaseAwareRequestBuilderFactory(databaseConfig: combinedConfig.databaseCache) :
            CachedRequestBuilderFactory(cacheConfiguration: combinedConfig.memoryCache)
    }
}

// Cache management utilities
public class CacheManager: @unchecked Sendable {
    public static let shared = CacheManager()
    
    private let memoryCache = APICache.shared
    private let databaseCache = DatabaseCache.shared
    private let hybridCache = HybridCache.shared
    
    private init() {}
    
    // Memory cache operations
    public func clearMemoryCache() async {
        await memoryCache.clear()
    }
    
    public func getMemoryCacheSize() async -> Int {
        await memoryCache.cacheSize
    }
    
    // Database cache operations  
    public func clearDatabaseCache() async {
        await databaseCache.clear()
    }
    
    public func getDatabaseCacheSize() async -> Int {
        await databaseCache.count()
    }
    
    public func clearExpiredDatabaseEntries() async -> Int {
        await databaseCache.clearExpired()
    }
    
    // Combined operations
    public func clearAllCaches() async {
        await clearMemoryCache()
        await clearDatabaseCache()
    }
    
    public func getCacheStatistics() async -> CacheStatistics {
        let memorySize = await getMemoryCacheSize()
        let databaseSize = await getDatabaseCacheSize()
        let expiredCount = await clearExpiredDatabaseEntries()
        
        return CacheStatistics(
            memoryItems: memorySize,
            databaseItems: databaseSize,
            expiredItemsCleared: expiredCount
        )
    }
    
    // Entity-specific operations
    public func getCachedEntity<T: DatabaseCacheable>(
        type: T.Type,
        primaryKey: String
    ) async -> T? {
        return await hybridCache.getEntity(type: type, primaryKey: primaryKey)
    }
    
    public func storeCachedEntity<T: DatabaseCacheable>(_ entity: T) async {
        await hybridCache.storeEntity(entity)
    }
}

public struct CacheStatistics: Sendable {
    public let memoryItems: Int
    public let databaseItems: Int
    public let expiredItemsCleared: Int
    
    public var totalItems: Int {
        memoryItems + databaseItems
    }
    
    public var description: String {
        """
        Cache Statistics:
        - Memory Cache: \(memoryItems) items
        - Database Cache: \(databaseItems) items
        - Total: \(totalItems) items
        - Expired Items Cleared: \(expiredItemsCleared)
        """
    }
}

// Automatic cache maintenance
public class CacheMaintenanceService: @unchecked Sendable {
    public static let shared = CacheMaintenanceService()
    
    private var maintenanceTask: Task<Void, Never>?
    private let maintenanceInterval: TimeInterval
    
    public init(maintenanceInterval: TimeInterval = 3600) { // 1 hour default
        self.maintenanceInterval = maintenanceInterval
    }
    
    public func startAutomaticMaintenance() {
        guard maintenanceTask == nil else { return }
        
        maintenanceTask = Task {
            while !Task.isCancelled {
                do {
                    // Clear expired database entries
                    let expiredCount = await DatabaseCache.shared.clearExpired()
                    if expiredCount > 0 {
                        print("Cache maintenance: Cleared \(expiredCount) expired database entries")
                    }
                    
                    // Wait for next maintenance cycle
                    try await Task.sleep(nanoseconds: UInt64(maintenanceInterval * 1_000_000_000))
                } catch {
                    // Task was cancelled or sleep interrupted
                    break
                }
            }
        }
    }
    
    public func stopAutomaticMaintenance() {
        maintenanceTask?.cancel()
        maintenanceTask = nil
    }
    
    deinit {
        stopAutomaticMaintenance()
    }
}