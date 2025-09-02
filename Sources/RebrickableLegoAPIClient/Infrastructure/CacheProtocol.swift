// CacheProtocol.swift
//
// Local caching infrastructure for RebrickableLegoAPIClient
//

import Foundation

public enum CacheError: Error {
    case invalidKey
    case expired
    case notFound
    case serializationFailed
    case deserializationFailed
}

public protocol CacheProtocol: Sendable {
    associatedtype Key: Hashable & Sendable
    associatedtype Value: Sendable
    
    func get(key: Key) async throws -> Value?
    func set(key: Key, value: Value, expiration: CacheExpiration?) async throws
    func remove(key: Key) async throws
    func clear() async throws
    func contains(key: Key) async -> Bool
}

public enum CacheExpiration: Sendable {
    case never
    case after(TimeInterval)
    case at(Date)
    
    var expirationDate: Date? {
        switch self {
        case .never:
            return nil
        case .after(let timeInterval):
            return Date().addingTimeInterval(timeInterval)
        case .at(let date):
            return date
        }
    }
    
    func isExpired(at date: Date = Date()) -> Bool {
        guard let expirationDate = expirationDate else { return false }
        return date >= expirationDate
    }
}

public protocol CacheKeyProtocol: Hashable, Sendable {
    var stringValue: String { get }
}

public struct APICacheKey: CacheKeyProtocol {
    public let endpoint: String
    public let parameters: [String: String]
    
    public init(endpoint: String, parameters: [String: String] = [:]) {
        self.endpoint = endpoint
        self.parameters = parameters
    }
    
    public var stringValue: String {
        let sortedParams = parameters.sorted { $0.key < $1.key }
        let paramString = sortedParams.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        return paramString.isEmpty ? endpoint : "\(endpoint)?\(paramString)"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(stringValue)
    }
    
    public static func == (lhs: APICacheKey, rhs: APICacheKey) -> Bool {
        lhs.stringValue == rhs.stringValue
    }
}