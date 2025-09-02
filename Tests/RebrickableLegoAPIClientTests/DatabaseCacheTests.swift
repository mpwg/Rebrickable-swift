// DatabaseCacheTests.swift
//
// Tests for database caching functionality
//

import Foundation
import Testing

@testable import RebrickableLegoAPIClient

final class DatabaseCacheTests {
    
    // MARK: - Database Cache Basic Operations
    
    @Test func testDatabaseCacheStoreAndRetrieve() async throws {
        let cache = DatabaseCache(filename: "test_cache_\(UUID().uuidString).sqlite")
        
        // Test storing and retrieving a Color entity
        let color = Color(externalIds: nil, id: 1, isTrans: false, name: "Red", rgb: "FF0000")
        
        try await cache.storeEntity(color)
        
        let retrieved = try await cache.getEntity(
            type: Color.self,
            primaryKey: "1",
            configuration: .default
        )
        
        #expect(retrieved?.id == 1)
        #expect(retrieved?.name == "Red")
        #expect(retrieved?.rgb == "FF0000")
        
        // Clean up
        await cache.clear()
    }
    
    @Test func testDatabaseCacheExpiration() async throws {
        let cache = DatabaseCache(filename: "test_expiration_\(UUID().uuidString).sqlite")
        await cache.clear() // Start with clean slate
        
        let color = Color(externalIds: nil, id: 2, isTrans: false, name: "Blue", rgb: "0000FF")
        
        // Store with short expiration
        try await cache.store(entity: color, expiration: .after(0.1)) // 100ms
        
        // Small delay to ensure write completes
        try await Task.sleep(nanoseconds: 50_000_000) // 50ms
        
        // Should be available immediately
        let immediate = try await cache.retrieve(type: Color.self, primaryKey: "2")
        #expect(immediate?.name == "Blue")
        
        // Wait for expiration
        try await Task.sleep(nanoseconds: 200_000_000) // 200ms
        
        // Should be expired and return nil
        let expired = try await cache.retrieve(type: Color.self, primaryKey: "2")
        #expect(expired == nil)
        
        // Clean up
        await cache.clear()
    }
    
    @Test func testDatabaseCacheDifferentEntityTypes() async throws {
        let cache = DatabaseCache(filename: "test_entities_\(UUID().uuidString).sqlite")
        
        // Test different entity types
        let color = Color(externalIds: nil, id: 3, isTrans: false, name: "Green", rgb: "00FF00")
        let theme = Theme(id: 1, parentId: nil, name: "City")
        let part = Part(
            partNum: "3001", name: "Brick 2x4", partCatId: 1,
            yearFrom: 1958, yearTo: nil, partUrl: "/parts/3001/"
        )
        
        try await cache.storeEntity(color)
        try await cache.storeEntity(theme)  
        try await cache.storeEntity(part)
        
        // Retrieve each entity
        let retrievedColor = try await cache.getEntity(type: Color.self, primaryKey: "3")
        let retrievedTheme = try await cache.getEntity(type: Theme.self, primaryKey: "1")
        let retrievedPart = try await cache.getEntity(type: Part.self, primaryKey: "3001")
        
        #expect(retrievedColor?.name == "Green")
        #expect(retrievedTheme?.name == "City")
        #expect(retrievedPart?.name == "Brick 2x4")
        
        // Clean up
        await cache.clear()
    }
    
    @Test func testDatabaseCacheCount() async throws {
        let cache = DatabaseCache(filename: "test_count_\(UUID().uuidString).sqlite")
        await cache.clear()
        
        let initialCount = await cache.count()
        #expect(initialCount == 0)
        
        // Add some entities
        let color1 = Color(externalIds: nil, id: 4, isTrans: false, name: "Yellow", rgb: "FFFF00")
        let color2 = Color(externalIds: nil, id: 5, isTrans: false, name: "Black", rgb: "000000")
        
        try await cache.storeEntity(color1)
        try await cache.storeEntity(color2)
        
        let countAfterAdding = await cache.count()
        #expect(countAfterAdding == 2)
        
        // Clean up
        await cache.clear()
        
        let finalCount = await cache.count()
        #expect(finalCount == 0)
    }
    
    // MARK: - Database Cache Configuration Tests
    
    @Test func testDatabaseCacheConfiguration() {
        let defaultConfig = DatabaseCacheConfiguration.default
        #expect(defaultConfig.isEnabled == true)
        
        let longTermConfig = DatabaseCacheConfiguration.longTerm
        #expect(longTermConfig.isEnabled == true)
        
        let disabledConfig = DatabaseCacheConfiguration.disabled
        #expect(disabledConfig.isEnabled == false)
        
        // Test entity-specific configuration
        let colorsConfig = longTermConfig.configurationFor(entityType: "colors")
        if case .never = colorsConfig.expiration {
            // Expected - colors never expire in long-term config
        } else {
            Issue.record("Expected never expiration for colors")
        }
    }
    
    @Test func testEntityDatabaseConfiguration() {
        let config = EntityDatabaseConfiguration(
            expiration: .after(3600),
            shouldCacheOnError: true
        )
        
        #expect(config.isEnabled == true)
        #expect(config.shouldCacheOnError == true)
        
        if case .after(let timeInterval) = config.expiration {
            #expect(timeInterval == 3600)
        } else {
            Issue.record("Expected .after expiration")
        }
    }
    
    // MARK: - Database Cacheable Models Tests
    
    @Test func testDatabaseCacheableModels() {
        // Test Color
        let color = Color(externalIds: nil, id: 10, isTrans: false, name: "White", rgb: "FFFFFF")
        #expect(color.primaryKey == "10")
        #expect(Color.tableName == "colors")
        
        // Test Theme  
        let theme = Theme(id: 2, parentId: 1, name: "Space")
        #expect(theme.primaryKey == "2")
        #expect(Theme.tableName == "themes")
        
        // Test Part
        let part = Part(
            partNum: "3002", name: "Brick 2x3", partCatId: 1,
            yearFrom: 1960, yearTo: nil, partUrl: "/parts/3002/"
        )
        #expect(part.primaryKey == "3002")
        #expect(Part.tableName == "parts")
        
        // Test PartCategory
        let category = PartCategory(id: 1, name: "Brick", partCount: 100)
        #expect(category.primaryKey == "1")
        #expect(PartCategory.tableName == "part_categories")
        
        // Test ModelSet
        let set = ModelSet(
            setNum: "60001-1", name: "Fire Chief Car", year: 2013,
            themeId: 1, numParts: 50, setImgUrl: "/sets/60001-1.jpg",
            setUrl: "/sets/60001-1/", lastModifiedDt: Date()
        )
        #expect(set.primaryKey == "60001-1")
        #expect(ModelSet.tableName == "sets")
    }
    
    // MARK: - Cache Manager Tests
    
    @Test func testCacheManager() async {
        let manager = CacheManager.shared
        
        // Clear all caches first
        await manager.clearAllCaches()
        
        let initialStats = await manager.getCacheStatistics()
        #expect(initialStats.databaseItems == 0)
        
        // Add a test entity
        let color = Color(externalIds: nil, id: 6, isTrans: false, name: "Purple", rgb: "800080")
        await manager.storeCachedEntity(color)
        
        // Retrieve the entity
        let retrieved = await manager.getCachedEntity(type: Color.self, primaryKey: "6")
        #expect(retrieved?.name == "Purple")
        
        // Check updated statistics
        let finalStats = await manager.getCacheStatistics()
        #expect(finalStats.databaseItems >= 1)
        
        // Clean up
        await manager.clearAllCaches()
    }
    
    // MARK: - Combined Cache Configuration Tests
    
    @Test func testCombinedCacheConfiguration() {
        let defaultConfig = CombinedCacheConfiguration.default
        #expect(defaultConfig.useDatabaseForSingleEntities == true)
        
        let performanceConfig = CombinedCacheConfiguration.performance
        #expect(performanceConfig.useDatabaseForSingleEntities == true)
        
        let memoryOnlyConfig = CombinedCacheConfiguration.memoryOnly
        #expect(memoryOnlyConfig.useDatabaseForSingleEntities == false)
        #expect(memoryOnlyConfig.databaseCache.isEnabled == false)
        
        let databaseOnlyConfig = CombinedCacheConfiguration.databaseOnly
        #expect(databaseOnlyConfig.useDatabaseForSingleEntities == true)
        #expect(databaseOnlyConfig.memoryCache.isEnabled == false)
        
        let disabledConfig = CombinedCacheConfiguration.disabled
        #expect(disabledConfig.useDatabaseForSingleEntities == false)
        #expect(disabledConfig.memoryCache.isEnabled == false)
        #expect(disabledConfig.databaseCache.isEnabled == false)
    }
    
    // MARK: - API Configuration Integration Tests
    
    @Test func testDatabaseCachingAPIConfiguration() {
        // Test database-only configuration
        let dbConfig = RebrickableLegoAPIClientAPIConfiguration.withDatabaseCaching()
        #expect(dbConfig.requestBuilderFactory is DatabaseAwareRequestBuilderFactory)
        
        // Test combined caching configuration  
        let combinedConfig = RebrickableLegoAPIClientAPIConfiguration.withCombinedCaching()
        #expect(combinedConfig.requestBuilderFactory is DatabaseAwareRequestBuilderFactory)
        #expect(combinedConfig.interceptor is CachingInterceptor)
        
        // Test memory-only combined configuration
        let memoryOnlyConfig = RebrickableLegoAPIClientAPIConfiguration.withCombinedCaching(
            combinedConfig: .memoryOnly
        )
        #expect(memoryOnlyConfig.requestBuilderFactory is CachedRequestBuilderFactory)
        #expect(memoryOnlyConfig.interceptor is CachingInterceptor)
    }
    
    @Test func testEnableDatabaseCachingOnSharedConfig() {
        let originalFactory = RebrickableLegoAPIClientAPIConfiguration.shared.requestBuilderFactory
        
        // Enable database caching
        RebrickableLegoAPIClientAPIConfiguration.shared.enableDatabaseCaching()
        #expect(RebrickableLegoAPIClientAPIConfiguration.shared.requestBuilderFactory is DatabaseAwareRequestBuilderFactory)
        
        // Restore original factory
        RebrickableLegoAPIClientAPIConfiguration.shared.requestBuilderFactory = originalFactory
    }
    
    // MARK: - Hybrid Cache Tests
    
    @Test func testHybridCacheConfiguration() {
        let defaultConfig = HybridCacheConfiguration.default
        #expect(defaultConfig.useDatabaseCache == true)
        #expect(defaultConfig.useMemoryCache == false) // Memory cache not ideal for entities
        
        let databaseOnlyConfig = HybridCacheConfiguration.databaseOnly
        #expect(databaseOnlyConfig.useDatabaseCache == true)
        #expect(databaseOnlyConfig.useMemoryCache == false)
        
        let disabledConfig = HybridCacheConfiguration.disabled
        #expect(disabledConfig.useDatabaseCache == false)
        #expect(disabledConfig.useMemoryCache == false)
    }
    
    // MARK: - Cache Maintenance Tests
    
    @Test func testCacheMaintenanceService() async {
        let maintenanceService = CacheMaintenanceService(maintenanceInterval: 0.1) // 100ms for testing
        
        // Start maintenance
        maintenanceService.startAutomaticMaintenance()
        
        // Let it run briefly
        try? await Task.sleep(nanoseconds: 50_000_000) // 50ms
        
        // Stop maintenance
        maintenanceService.stopAutomaticMaintenance()
        
        // Test that it can be restarted
        maintenanceService.startAutomaticMaintenance()
        maintenanceService.stopAutomaticMaintenance()
    }
}