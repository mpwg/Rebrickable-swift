// DatabaseCache.swift
//
// SQLite-based persistent cache for single entity storage
//

import Foundation
import SQLite3

private let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

public enum DatabaseError: Error, Sendable {
    case openDatabase(String)
    case prepare(String)
    case step(String)
    case bind(String)
    case notFound
    case serializationFailed
    case deserializationFailed
}

public protocol DatabaseCacheable: Codable, Sendable {
    var primaryKey: String { get }
    static var tableName: String { get }
}

public final class DatabaseCache: @unchecked Sendable {
    private var db: OpaquePointer?
    private let dbPath: String
    private let queue = DispatchQueue(label: "com.rebrickable.database.cache", qos: .utility)
    
    public static let shared = DatabaseCache()
    
    public init(filename: String = "rebrickable_cache.sqlite") {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let cacheDirectory = urls.first ?? FileManager.default.temporaryDirectory
        self.dbPath = cacheDirectory.appendingPathComponent(filename).path
        
        openDatabase()
        createTables()
    }
    
    deinit {
        if let db = db {
            sqlite3_close(db)
        }
    }
    
    private func openDatabase() {
        let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_FULLMUTEX
        
        if sqlite3_open_v2(dbPath, &db, flags, nil) != SQLITE_OK {
            let message = String(cString: sqlite3_errmsg(db))
            print("Unable to open database: \(message)")
            db = nil
        }
        
        // Enable WAL mode for better concurrency
        _ = executeSQL("PRAGMA journal_mode=WAL")
        
        // Set synchronous to NORMAL for better performance
        _ = executeSQL("PRAGMA synchronous=NORMAL")
        
        // Set cache size to 10MB
        _ = executeSQL("PRAGMA cache_size=10000")
    }
    
    private func createTables() {
        // Generic cache table for storing JSON data
        let createCacheTable = """
            CREATE TABLE IF NOT EXISTS entity_cache (
                table_name TEXT NOT NULL,
                primary_key TEXT NOT NULL,
                data TEXT NOT NULL,
                created_at INTEGER NOT NULL,
                expires_at INTEGER,
                PRIMARY KEY (table_name, primary_key)
            )
        """
        
        let createIndexes = [
            "CREATE INDEX IF NOT EXISTS idx_expires_at ON entity_cache(expires_at)",
            "CREATE INDEX IF NOT EXISTS idx_created_at ON entity_cache(created_at)",
            "CREATE INDEX IF NOT EXISTS idx_table_name ON entity_cache(table_name)"
        ]
        
        _ = executeSQL(createCacheTable)
        
        for indexSQL in createIndexes {
            _ = executeSQL(indexSQL)
        }
    }
    
    private func executeSQL(_ sql: String) -> Bool {
        guard let db = db else { return false }
        
        var statement: OpaquePointer?
        defer {
            if statement != nil {
                sqlite3_finalize(statement)
            }
        }
        
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK {
            let message = String(cString: sqlite3_errmsg(db))
            print("Error preparing statement: \(message)")
            return false
        }
        
        let stepResult = sqlite3_step(statement)
        if stepResult != SQLITE_DONE && stepResult != SQLITE_ROW {
            let message = String(cString: sqlite3_errmsg(db))
            print("Error executing statement: \(message) (result code: \(stepResult))")
            return false
        }
        
        // If we got a row result (like from PRAGMA), step through all rows
        if stepResult == SQLITE_ROW {
            while sqlite3_step(statement) == SQLITE_ROW {
                // Just consume the rows for PRAGMA statements
            }
        }
        
        return true
    }
    
    public func store<T: DatabaseCacheable>(
        entity: T,
        expiration: CacheExpiration? = nil
    ) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            queue.async {
                do {
                    let jsonData = try JSONEncoder().encode(entity as T)
                    let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
                    
                    let now = Int64(Date().timeIntervalSince1970)
                    let expiresAt: Int64? = {
                        if let expirationDate = expiration?.expirationDate {
                            return Int64(expirationDate.timeIntervalSince1970)
                        }
                        return nil
                    }()
                    
                    let sql = """
                        INSERT OR REPLACE INTO entity_cache 
                        (table_name, primary_key, data, created_at, expires_at)
                        VALUES (?, ?, ?, ?, ?)
                    """
                    
                    guard let db = self.db else {
                        continuation.resume(throwing: DatabaseError.openDatabase("Database not available"))
                        return
                    }
                    
                    var statement: OpaquePointer?
                    defer {
                        if statement != nil {
                            sqlite3_finalize(statement)
                        }
                    }
                    
                    if sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK {
                        let message = String(cString: sqlite3_errmsg(db))
                        continuation.resume(throwing: DatabaseError.prepare(message))
                        return
                    }
                    
                    sqlite3_bind_text(statement, 1, T.tableName, -1, SQLITE_TRANSIENT)
                    sqlite3_bind_text(statement, 2, entity.primaryKey, -1, SQLITE_TRANSIENT)
                    sqlite3_bind_text(statement, 3, jsonString, -1, SQLITE_TRANSIENT)
                    sqlite3_bind_int64(statement, 4, now)
                    
                    if let expiresAt = expiresAt {
                        sqlite3_bind_int64(statement, 5, expiresAt)
                    } else {
                        sqlite3_bind_null(statement, 5)
                    }
                    
                    if sqlite3_step(statement) != SQLITE_DONE {
                        let message = String(cString: sqlite3_errmsg(db))
                        continuation.resume(throwing: DatabaseError.step(message))
                        return
                    }
                    
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func retrieve<T: DatabaseCacheable>(
        type: T.Type,
        primaryKey: String
    ) async throws -> T? {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                do {
                    let sql = """
                        SELECT data, expires_at 
                        FROM entity_cache 
                        WHERE table_name = ? AND primary_key = ?
                    """
                    
                    guard let db = self.db else {
                        continuation.resume(throwing: DatabaseError.openDatabase("Database not available"))
                        return
                    }
                    
                    var statement: OpaquePointer?
                    defer {
                        if statement != nil {
                            sqlite3_finalize(statement)
                        }
                    }
                    
                    if sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK {
                        let message = String(cString: sqlite3_errmsg(db))
                        continuation.resume(throwing: DatabaseError.prepare(message))
                        return
                    }
                    
                    sqlite3_bind_text(statement, 1, T.tableName, -1, SQLITE_TRANSIENT)
                    sqlite3_bind_text(statement, 2, primaryKey, -1, SQLITE_TRANSIENT)
                    
                    let result = sqlite3_step(statement)
                    
                    if result == SQLITE_ROW {
                        guard let dataPtr = sqlite3_column_text(statement, 0) else {
                            continuation.resume(returning: nil)
                            return
                        }
                        
                        let jsonString = String(cString: dataPtr)
                        
                        // Check expiration
                        let expiresAtType = sqlite3_column_type(statement, 1)
                        if expiresAtType != SQLITE_NULL {
                            let expiresAt = sqlite3_column_int64(statement, 1)
                            let expirationDate = Date(timeIntervalSince1970: TimeInterval(expiresAt))
                            
                            if Date() >= expirationDate {
                                // Expired, remove from database
                                self.remove(type: T.self, primaryKey: primaryKey) { _ in }
                                continuation.resume(returning: nil)
                                return
                            }
                        }
                        
                        guard let jsonData = jsonString.data(using: .utf8) else {
                            continuation.resume(throwing: DatabaseError.deserializationFailed)
                            return
                        }
                        
                        let entity = try JSONDecoder().decode(T.self, from: jsonData)
                        continuation.resume(returning: entity)
                        
                    } else if result == SQLITE_DONE {
                        continuation.resume(returning: nil)
                    } else {
                        let message = String(cString: sqlite3_errmsg(db))
                        continuation.resume(throwing: DatabaseError.step(message))
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func remove<T: DatabaseCacheable>(
        type: T.Type,
        primaryKey: String,
        completion: @escaping @Sendable (Result<Void, Error>) -> Void = { _ in }
    ) {
        queue.async {
            let sql = "DELETE FROM entity_cache WHERE table_name = ? AND primary_key = ?"
            
            guard let db = self.db else {
                completion(.failure(DatabaseError.openDatabase("Database not available")))
                return
            }
            
            var statement: OpaquePointer?
            defer {
                if statement != nil {
                    sqlite3_finalize(statement)
                }
            }
            
            if sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK {
                let message = String(cString: sqlite3_errmsg(db))
                completion(.failure(DatabaseError.prepare(message)))
                return
            }
            
            sqlite3_bind_text(statement, 1, T.tableName, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 2, primaryKey, -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(statement) != SQLITE_DONE {
                let message = String(cString: sqlite3_errmsg(db))
                completion(.failure(DatabaseError.step(message)))
                return
            }
            
            completion(.success(()))
        }
    }
    
    public func clearExpired() async -> Int {
        await withCheckedContinuation { continuation in
            queue.async {
                let now = Int64(Date().timeIntervalSince1970)
                let sql = "DELETE FROM entity_cache WHERE expires_at IS NOT NULL AND expires_at <= ?"
                
                guard let db = self.db else {
                    continuation.resume(returning: 0)
                    return
                }
                
                var statement: OpaquePointer?
                defer {
                    if statement != nil {
                        sqlite3_finalize(statement)
                    }
                }
                
                if sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK {
                    continuation.resume(returning: 0)
                    return
                }
                
                sqlite3_bind_int64(statement, 1, now)
                
                if sqlite3_step(statement) != SQLITE_DONE {
                    continuation.resume(returning: 0)
                    return
                }
                
                let deletedCount = Int(sqlite3_changes(db))
                continuation.resume(returning: deletedCount)
            }
        }
    }
    
    public func clear() async {
        await withCheckedContinuation { continuation in
            queue.async {
                _ = self.executeSQL("DELETE FROM entity_cache")
                continuation.resume(returning: ())
            }
        }
    }
    
    public func count() async -> Int {
        await withCheckedContinuation { continuation in
            queue.async {
                let sql = "SELECT COUNT(*) FROM entity_cache"
                
                guard let db = self.db else {
                    continuation.resume(returning: 0)
                    return
                }
                
                var statement: OpaquePointer?
                defer {
                    if statement != nil {
                        sqlite3_finalize(statement)
                    }
                }
                
                if sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK {
                    continuation.resume(returning: 0)
                    return
                }
                
                if sqlite3_step(statement) == SQLITE_ROW {
                    let count = Int(sqlite3_column_int(statement, 0))
                    continuation.resume(returning: count)
                } else {
                    continuation.resume(returning: 0)
                }
            }
        }
    }
}