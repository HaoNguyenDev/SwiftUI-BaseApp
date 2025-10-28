//
//  UserSettings.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import Foundation
import UIKit
import SwiftUI
import Observation
import KeychainAccess
import Kingfisher

extension UserSettings {
    // MARK: - Keys
    private enum UserSettingKeys {
        static let hasFinishSplash = "hasFinishSplash"
        static let signature = "signature"
        static let referralCode = "referralCode"
        static let languageCode = "languageCode"
        static let colorSchemeOption = "colorSchemeOption"
        static let launchCount = "launchCount"
        static let currentUser = "currentUser"
    }
}

@Observable final class UserSettings {
    private let defaults = UserDefaults.standard
    private let keychain = KeychainManager.shared
    private let themeManager = ThemeManager.shared
    
    private(set) var colorSchemeOption: ColorSchemeOption = .system {
        didSet {
            defaults.set(colorSchemeOption.rawValue, forKey: UserSettingKeys.colorSchemeOption)
            updateTheme(colorSchemeOption) // Update theme
        }
    }
    
    private var _token: String? = nil
    private var _refreshToken: String? = nil
    private var _username: String? = nil
    private var _password: String? = nil
    private var _userId: String? = nil
    
    init() {
        // Load values from UserDefaults
        if let rawValue = defaults.string(forKey: UserSettingKeys.colorSchemeOption),
           let savedOption = ColorSchemeOption(rawValue: rawValue) {
            self.colorSchemeOption = savedOption
        } else {
            self.colorSchemeOption = .system
        }
        
        self.referralCode = defaults.string(forKey: UserSettingKeys.referralCode)
        self.signature = defaults.string(forKey: UserSettingKeys.signature)
        self.languageCode = defaults.string(forKey: UserSettingKeys.languageCode)
        self.hasFinishSplash = defaults.bool(forKey: UserSettingKeys.hasFinishSplash)
        
        if let languageCode = LanguageCode(rawValue: languageCode ?? LanguageCode.eng.rawValue)?.getLanguage() {
            LanguageManager.shared.setLanguage(language: languageCode)
        }
    }
    
    var hasFinishSplash: Bool {
        didSet {
            defaults.set(hasFinishSplash, forKey: UserSettingKeys.hasFinishSplash)
        }
    }
    
    var languageCode: String? {
        didSet {
            Logger.shared.info("languageCode set to: \(languageCode ?? "nil")")
            defaults.set(languageCode, forKey: UserSettingKeys.languageCode)
        }
    }
    
    var hasLoggedIn: Bool {
        get {
            guard let token = _token else { return false }
            return token != ""
        }
    }
    
    var token: String? {
        get {
            return _token
        }
        set {
            _token = newValue
            Task {
                await saveValueToKeychain(newValue, for: .token)
            }
        }
    }
    
    var refreshToken: String? {
        get {
            return _refreshToken
        }
        set {
            _refreshToken = newValue
            Task {
                await saveValueToKeychain(newValue, for: .refreshToken)
            }
        }
    }
    
    var username: String? {
        get {
            return _username
        }
        set {
            _username = newValue
            Task {
                await saveValueToKeychain(newValue, for: .username)
            }
        }
    }
    
    var password: String? {
        get {
            return _password
        }
        
        set {
            _password = newValue
            Task {
                await saveValueToKeychain(newValue, for: .password)
            }
        }
    }
    
    var signature: String? {
        didSet {
            defaults.set(signature, forKey: UserSettingKeys.signature)
        }
    }
    
    var userId: String? {
        get {
            return _userId
        }
        set {
            _username = newValue
            Task {
                await saveValueToKeychain(newValue, for: .userId)
            }
        }
    }
    
    var referralCode: String? {
        didSet {
            defaults.set(referralCode, forKey: UserSettingKeys.referralCode)
        }
    }
    
    func logout() {
        clearUserData()
        // NotificationCenter.default.post(name: AppNotification.LOGOUT, object: nil)
    }
    
}

extension UserSettings {
    // MARK: - Load Keychain value
    /// Call at @main or App struct
    static func loadSettings() async -> UserSettings {
        let settings = UserSettings()
        settings._token = await settings.loadValueFromKeychain(for: .token)
        settings._refreshToken = await settings.loadValueFromKeychain(for: .refreshToken)
        settings._username = await settings.loadValueFromKeychain(for: .username)
        settings._password = await settings.loadValueFromKeychain(for: .password)
        settings._userId = await settings.loadValueFromKeychain(for: .userId)
        
        do {
            try await Task.sleep(for: .seconds(0.5))
        } catch {
            Logger.shared.debug(error.localizedDescription)
        }
        
        return settings
    }
    // MARK: - Manual Reload
    /// call this func when refresh token or change password
    @MainActor
    func refreshKeychainData() async {
        _token = await loadValueFromKeychain(for: .token)
        _username = await loadValueFromKeychain(for: .username)
    }
}


extension UserSettings {
    private func clearUserData() {
        token = nil
        username = nil
        referralCode = nil
        userId = nil
        signature = nil
    }
    
    func clearCache() {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
        cache.cleanExpiredDiskCache()
    }
}

extension UserSettings {
    
    func setColorScheme(_ option: ColorSchemeOption, systemColorScheme: ColorScheme = .light) {
        self.colorSchemeOption = option
        self.updateTheme(option, systemColorScheme: systemColorScheme)
    }

    private func updateTheme(_ option: ColorSchemeOption, systemColorScheme: ColorScheme = .light) {
        switch option {
        case .system:
            themeManager.currentTheme = systemColorScheme == .dark ? DarkTheme() : LightTheme()
        case .light:
            themeManager.currentTheme = LightTheme()
        case .dark:
            themeManager.currentTheme = DarkTheme()
        }
    }
}

extension UserSettings {
    func getLanguage(_ languageCode: String) -> LanguageCode {
        switch languageCode {
        case "eng": return LanguageCode.eng
        case "chs": return LanguageCode.chs
        case "vi": return LanguageCode.vi
        default: return LanguageCode.eng
        }
    }
}

// MARK: - Keychain helper
extension UserSettings {
    @MainActor
    private func loadValueFromKeychain(for key: KeychainManager.KeychainKeys) async -> String? {
        do {
            return try await keychain.loadValueFromKeychain(for: key)
        } catch {
            Logger.shared.debug("Error when load value from keychain: \(error.localizedDescription)")
            return nil
        }
    }

    @MainActor
    private func saveValueToKeychain(_ value: String?, for key: KeychainManager.KeychainKeys) async {
        guard let value = value else {
            do {
                try await keychain.deleteValueFromKeychain(for: key)
            } catch {
                Logger.shared.debug("Error when delete value from keychain: \(error.localizedDescription)")
            }
            return
        }
        
        do {
            try await keychain.saveValueToKeychain(value, for: key)
        } catch {
            Logger.shared.debug("Error when save value to keychain: \(error.localizedDescription)")
        }
    }
}
