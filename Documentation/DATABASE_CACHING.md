# Database Caching

The Rebrickable Swift API Client includes a robust SQLite-based database caching system for persistent storage of single entities. This provides offline access and improved performance by reducing API calls.

## Overview

Database caching complements the existing memory cache by providing persistent storage that survives app restarts. It's particularly useful for:

- Storing frequently accessed entities (colors, themes, parts)
- Offline functionality
- Reducing API rate limit pressure
- Improving app startup time

## Supported Entity Types

The following entity types support database caching:

- `Color` - LEGO colors with RGB values
- `Theme` - LEGO themes (City, Space, etc.)
- `Part` - Individual LEGO parts
- `PartCategory` - Part categories (brick, plate, etc.)
- `ModelSet` - LEGO sets and minifigures
- `Element` - Specific part-color combinations
- `PartColor` - Part color availability data

## Basic Usage

### Automatic Caching

The simplest way to use database caching is through automatic integration with API calls:

```swift
// Configure API client with database caching
let config = RebrickableLegoAPIClientAPIConfiguration.withDatabaseCaching()
RebrickableLegoAPIClientAPIConfiguration.shared = config

// API calls will now automatically cache responses
let api = LegoAPI()
let color = try await api.getColor(id: 1) // Cached automatically
let sameCcolor = try await api.getColor(id: 1) // Retrieved from cache
```

### Manual Cache Operations

For direct cache manipulation:

```swift
let cache = DatabaseCache.shared

// Store an entity
let color = Color(externalIds: nil, id: 1, isTrans: false, name: "Red", rgb: "FF0000")
try await cache.storeEntity(color)

// Retrieve an entity
let retrieved = try await cache.getEntity(type: Color.self, primaryKey: "1")

// Remove an entity
await cache.removeEntity(type: Color.self, primaryKey: "1")

// Clear all cached data
await cache.clear()
```

## Configuration

### Cache Configurations

Choose from predefined configurations based on your needs:

```swift
// Default configuration (24 hours expiration)
let defaultConfig = DatabaseCacheConfiguration.default

// Long-term caching (7 days, colors never expire)
let longTermConfig = DatabaseCacheConfiguration.longTerm

// Short-term caching (1 hour)
let shortTermConfig = DatabaseCacheConfiguration.shortTerm

// Disable caching
let disabledConfig = DatabaseCacheConfiguration.disabled
```

### Entity-Specific Configuration

Configure different expiration times for different entity types:

```swift
let customConfig = DatabaseCacheConfiguration(
    defaultExpiration: .after(3600), // 1 hour default
    entityConfigurations: [
        "colors": EntityDatabaseConfiguration(expiration: .never), // Colors never change
        "themes": EntityDatabaseConfiguration(expiration: .after(86400)), // 1 day
        "parts": EntityDatabaseConfiguration(expiration: .after(3600)) // 1 hour
    ]
)
```

### Combined Caching

Use both memory and database caching together:

```swift
// Memory + Database caching
let config = RebrickableLegoAPIClientAPIConfiguration.withCombinedCaching()

// Memory-only caching
let memoryConfig = RebrickableLegoAPIClientAPIConfiguration.withCombinedCaching(
    combinedConfig: .memoryOnly
)

// Database-only caching
let dbConfig = RebrickableLegoAPIClientAPIConfiguration.withCombinedCaching(
    combinedConfig: .databaseOnly
)
```

## Cache Management

### Cache Statistics

Monitor cache performance:

```swift
let manager = CacheManager.shared
let stats = await manager.getCacheStatistics()

print("Memory items: \(stats.memoryItems)")
print("Database items: \(stats.databaseItems)")
print("Total items: \(stats.totalItems)")
```

### Cache Maintenance

Perform cache maintenance operations:

```swift
let manager = CacheManager.shared

// Clear expired entries
let expiredCount = await manager.clearExpiredDatabaseEntries()
print("Cleared \(expiredCount) expired entries")

// Clear all caches
await manager.clearAllCaches()

// Get cache sizes
let memorySize = await manager.getMemoryCacheSize()
let dbSize = await manager.getDatabaseCacheSize()
```

### Automatic Maintenance

Enable automatic cleanup of expired entries:

```swift
let maintenanceService = CacheMaintenanceService.shared
maintenanceService.startAutomaticMaintenance() // Runs every hour by default

// Custom maintenance interval (every 30 minutes)
let customService = CacheMaintenanceService(maintenanceInterval: 1800)
customService.startAutomaticMaintenance()

// Stop automatic maintenance
maintenanceService.stopAutomaticMaintenance()
```

## Advanced Usage

### Hybrid Cache

Use the hybrid cache for combined memory and database operations:

```swift
let hybridCache = HybridCache.shared

// Store entity (goes to both memory and database)
await hybridCache.storeEntity(color)

// Retrieve entity (tries memory first, then database)
let cached = await hybridCache.getEntity(type: Color.self, primaryKey: "1")

// Clear expired entries
let expiredCount = await hybridCache.clearExpiredEntities()

// Clear all caches
await hybridCache.clearAllEntities()
```

### Custom Database Location

Use a custom database file location:

```swift
let customCache = DatabaseCache(filename: "my_custom_cache.sqlite")
try await customCache.storeEntity(color)
```

### Error Handling

Handle cache errors gracefully:

```swift
do {
    try await cache.storeEntity(color)
    let retrieved = try await cache.getEntity(type: Color.self, primaryKey: "1")
} catch DatabaseError.openDatabase(let message) {
    print("Database connection failed: \(message)")
} catch DatabaseError.serializationFailed {
    print("Failed to serialize entity to JSON")
} catch DatabaseError.deserializationFailed {
    print("Failed to deserialize entity from JSON")
} catch {
    print("Unexpected error: \(error)")
}
```

## Cache Expiration

### Expiration Types

```swift
// Never expire
.never

// Expire after time interval (seconds)
.after(3600) // 1 hour

// Expire at specific date
.at(Date().addingTimeInterval(86400)) // Tomorrow
```

### Checking Expiration

The cache automatically handles expiration:

- Expired entries return `nil` when retrieved
- Expired entries are automatically removed during retrieval
- Use `clearExpired()` to manually clean up expired entries

## Best Practices

### 1. Choose Appropriate Expiration Times

```swift
let config = DatabaseCacheConfiguration(
    entityConfigurations: [
        "colors": EntityDatabaseConfiguration(expiration: .never), // Rarely change
        "themes": EntityDatabaseConfiguration(expiration: .after(604800)), // Weekly
        "parts": EntityDatabaseConfiguration(expiration: .after(86400)), // Daily
        "sets": EntityDatabaseConfiguration(expiration: .after(3600)) // Hourly
    ]
)
```

### 2. Monitor Cache Size

```swift
// Periodic cache size monitoring
let stats = await CacheManager.shared.getCacheStatistics()
if stats.databaseItems > 10000 {
    await CacheManager.shared.clearExpiredDatabaseEntries()
}
```

### 3. Handle Network Errors

The cache can serve stale data when network requests fail:

```swift
let config = DatabaseCacheConfiguration(
    entityConfigurations: [
        "colors": EntityDatabaseConfiguration(shouldCacheOnError: true)
    ]
)
```

### 4. Use Appropriate Cache Strategy

```swift
// For apps with limited memory
let config = CombinedCacheConfiguration.databaseOnly

// For high-performance apps
let config = CombinedCacheConfiguration.performance

// For storage-conscious apps
let config = CombinedCacheConfiguration.memoryOnly
```

## Implementation Details

### Database Schema

The cache uses a generic SQLite table:

```sql
CREATE TABLE entity_cache (
    table_name TEXT NOT NULL,      -- Entity type identifier
    primary_key TEXT NOT NULL,     -- Entity primary key
    data TEXT NOT NULL,            -- JSON serialized entity
    created_at INTEGER NOT NULL,   -- Creation timestamp
    expires_at INTEGER,            -- Expiration timestamp (nullable)
    PRIMARY KEY (table_name, primary_key)
);
```

### Thread Safety

All cache operations are thread-safe and use a dedicated dispatch queue for SQLite operations.

### Performance Considerations

- Database operations are performed asynchronously
- WAL mode is enabled for better concurrency
- Indexes are created on frequently queried columns
- Cache size is limited to 10MB by default

## Troubleshooting

### Common Issues

1. **Cache not working**: Ensure caching is enabled in configuration
2. **Data not persisting**: Check database file permissions
3. **Performance issues**: Monitor cache size and clear expired entries
4. **Memory usage**: Use database-only configuration for large datasets

### Debug Information

Enable debug logging to monitor cache operations:

```swift
// Cache operations will print debug information to console
let cache = DatabaseCache(filename: "debug_cache.sqlite")
```

### Testing

Run the test suite to verify cache functionality:

```bash
swift test --filter DatabaseCacheTests
```

This will run all database caching tests to ensure proper functionality.