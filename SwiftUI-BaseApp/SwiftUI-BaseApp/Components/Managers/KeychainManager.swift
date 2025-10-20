//
//  KeychainManager.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 20/10/25.
//


import KeychainAccess
import Foundation

actor KeychainManager {
    
    static let shared = KeychainManager()
    private let keychain: Keychain
    
    private init() {
        keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "haonguyen.SwiftUI-BaseApp")
    }
    
    func loadValueFromKeychain(for key: KeychainKeys) throws -> String? {
        return try keychain.get(key.rawValue)
    }
    
    func saveValueToKeychain(_ value: String, for key: KeychainKeys) throws {
        try keychain.set(value, key: key.rawValue)
    }
    
    func deleteValueFromKeychain(for key: KeychainKeys) throws {
        try keychain.remove(key.rawValue)
    }
    
    func clearAllKeychainValues() throws {
        try keychain.allKeys().forEach { try keychain.remove($0) }
    }
}

extension KeychainManager {
    enum KeychainKeys: String, CaseIterable {
        case username = "haonguyen.SwiftUI-BaseApp.key.username"
        case password = "haonguyen.SwiftUI-BaseApp.key.password"
        case token = "haonguyen.SwiftUI-BaseApp.key.token"
        case userId = "haonguyen.SwiftUI-BaseApp.key.userId"
    }
}
