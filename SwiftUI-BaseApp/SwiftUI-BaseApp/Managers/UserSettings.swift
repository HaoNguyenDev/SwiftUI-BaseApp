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

extension UserSettings {
    // MARK: - Keys
    private enum UserSettingKeys {
        static let signature = "signature"
        static let userId = "userId"
        static let referralCode = "referralCode"
        static let languageCode = "languageCode"
        static let colorSchemeOption = "colorSchemeOption"
        static let launchCount = "launchCount"
        static let currentUser = "currentUser"
    }
    
    private enum KeychainAccessKeys {
        static let token = "token"
        static let username = "username"
    }
}

@Observable final class UserSettings {
    private let defaults = UserDefaults.standard
    private let keychainAccess = Keychain(service: Bundle.main.bundleIdentifier ?? "")
    private(set) var colorSchemeOption: ColorSchemeOption = .system {
        didSet {
            defaults.set(colorSchemeOption.rawValue, forKey: UserSettingKeys.colorSchemeOption)
            updateTheme(colorSchemeOption) // Update colorSet
        }
    }
    
    var languageCode: String? {
        didSet {
            Logger.shared.info("languageCode set to: \(languageCode ?? "nil")")
            defaults.set(languageCode, forKey: UserSettingKeys.languageCode)
        }
    }
    
    private(set) var themeSet: Theme
    
    var username: String? {
        get {
            keychainAccess[KeychainAccessKeys.username]
        }
        
        set {
            keychainAccess[KeychainAccessKeys.username] = newValue
        }
    }
    
    var token: String? {
        get {
            keychainAccess[KeychainAccessKeys.token]
        }
        
        set {
            keychainAccess[KeychainAccessKeys.token] = newValue
        }
    }
    
    var signature: String? {
        didSet {
            defaults.set(signature, forKey: UserSettingKeys.signature)
        }
    }
    
    var userId: String? {
        didSet {
            defaults.set(userId, forKey: UserSettingKeys.userId)
        }
    }
    
    var referralCode: String? {
        didSet {
            defaults.set(referralCode, forKey: UserSettingKeys.referralCode)
        }
    }
    
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
        
        themeSet = LightTheme()
        updateTheme(colorSchemeOption)
        
        if let languageCode = LanguageCode(rawValue: languageCode ?? LanguageCode.eng.rawValue)?.getLanguage() {
            LanguageManager.shared.setLanguage(language: languageCode)
        }
    }
    
    var hasLogin: Bool {
        return token != nil && token != ""
    }
    
    func logout() {
        username = nil
        token = nil
        referralCode = nil

        keychainAccess[KeychainAccessKeys.username] = nil
        keychainAccess[KeychainAccessKeys.token] = nil
        defaults.removeObject(forKey: UserSettingKeys.referralCode)
        
        // NotificationCenter.default.post(name: AppNotification.LOGOUT, object: nil)
    }

    
}

extension UserSettings {
    var theme: Theme {
        return themeSet
    }
    
    func setColorScheme(_ option: ColorSchemeOption, systemColorScheme: ColorScheme = .light) {
        self.colorSchemeOption = option
        self.updateTheme(option, systemColorScheme: systemColorScheme)
    }

    private func updateTheme(_ option: ColorSchemeOption, systemColorScheme: ColorScheme = .light) {
        switch option {
        case .system:
            themeSet = systemColorScheme == .dark ? DarkTheme() : LightTheme()
        case .light:
            themeSet = LightTheme()
        case .dark:
            themeSet = DarkTheme()
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

