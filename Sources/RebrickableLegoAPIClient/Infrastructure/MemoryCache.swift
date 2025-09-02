// MemoryCache.swift
//
// In-memory cache implementation for RebrickableLegoAPIClient
//

import Foundation

struct CachedItem<Value: Sendable>: Sendable {
    let value: Value
    let expirationDate: Date?
    let createdAt: Date

    init(value: Value, expiration: CacheExpiration?) {
        self.value = value
        expirationDate = expiration?.expirationDate
        createdAt = Date()
    }

    func isExpired(at date: Date = Date()) -> Bool {
        guard let expirationDate = expirationDate else { return false }
        return date >= expirationDate
    }
}

public actor MemoryCache<Key: CacheKeyProtocol, Value: Sendable>: CacheProtocol {
    private var storage: [Key: CachedItem<Value>] = [:]
    private let maxSize: Int
    private var accessOrder: [Key] = [] // For LRU eviction

    public init(maxSize: Int = 100) {
        self.maxSize = maxSize
    }

    public func get(key: Key) async throws -> Value? {
        cleanExpiredItems()

        guard let item = storage[key] else {
            return nil
        }

        if item.isExpired() {
            storage.removeValue(forKey: key)
            accessOrder.removeAll { $0 == key }
            throw CacheError.expired
        }

        // Update access order for LRU
        if let index = accessOrder.firstIndex(of: key) {
            accessOrder.remove(at: index)
        }
        accessOrder.append(key)

        return item.value
    }

    public func set(key: Key, value: Value, expiration: CacheExpiration? = nil) async throws {
        let item = CachedItem(value: value, expiration: expiration)
        storage[key] = item

        // Update access order
        if let index = accessOrder.firstIndex(of: key) {
            accessOrder.remove(at: index)
        }
        accessOrder.append(key)

        // Enforce size limit with LRU eviction
        while storage.count > maxSize {
            guard let oldestKey = accessOrder.first else { break }
            storage.removeValue(forKey: oldestKey)
            accessOrder.removeFirst()
        }
    }

    public func remove(key: Key) async throws {
        storage.removeValue(forKey: key)
        accessOrder.removeAll { $0 == key }
    }

    public func clear() async throws {
        storage.removeAll()
        accessOrder.removeAll()
    }

    public func contains(key: Key) async -> Bool {
        cleanExpiredItems()

        guard let item = storage[key] else {
            return false
        }

        return !item.isExpired()
    }

    private func cleanExpiredItems() {
        let currentDate = Date()
        let expiredKeys = storage.compactMap { key, item in
            item.isExpired(at: currentDate) ? key : nil
        }

        for key in expiredKeys {
            storage.removeValue(forKey: key)
            accessOrder.removeAll { $0 == key }
        }
    }

    // Additional utility methods
    public var count: Int {
        cleanExpiredItems()
        return storage.count
    }

    public var isEmpty: Bool {
        cleanExpiredItems()
        return storage.isEmpty
    }
}
