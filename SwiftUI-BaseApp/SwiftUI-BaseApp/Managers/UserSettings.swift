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

extension UserSettings {
    // MARK: - Keys
    private enum Keys {
        static let username = "username"
        static let token = ""
        static let signature = "signature"
        static let userId = "userId"
        static let referralCode = "referralCode"
        static let languageCode = "languageCode"
        static let colorSchemeOption = "colorSchemeOption"
        static let launchCount = "launchCount"
        static let currentUser = "currentUser"
    }
}

@Observable final class UserSettings {
  
    private let defaults = UserDefaults.standard
    
    private(set) var colorSchemeOption: ColorSchemeOption = .system {
        didSet {
            defaults.set(colorSchemeOption.rawValue, forKey: Keys.colorSchemeOption)
            updateTheme(colorSchemeOption) // Update colorSet
        }
    }
    
    var languageCode: String? {
        didSet {
            Logger.shared.info("languageCode set to: \(languageCode ?? "nil")")
            defaults.set(languageCode, forKey: Keys.languageCode)
        }
    }
    
    private(set) var colorSet: ColorSet
    
    var username: String? {
        didSet {
            defaults.set(username, forKey: Keys.username)
        }
    }
    
    var token: String? {
        didSet {
            defaults.set(token, forKey: Keys.token)
        }
    }
    
    var signature: String? {
        didSet {
            defaults.set(signature, forKey: Keys.signature)
        }
    }
    
    var userId: String? {
        didSet {
            defaults.set(userId, forKey: Keys.userId)
        }
    }
    
    var referralCode: String? {
        didSet {
            defaults.set(referralCode, forKey: Keys.referralCode)
        }
    }
    
    init() {
        // Load giá trị từ UserDefaults
        if let rawValue = defaults.string(forKey: Keys.colorSchemeOption),
           let savedOption = ColorSchemeOption(rawValue: rawValue) {
            self.colorSchemeOption = savedOption
        } else {
            self.colorSchemeOption = .system
        }
        
        self.username = defaults.string(forKey: Keys.username)
        self.token = defaults.string(forKey: Keys.token)
        self.referralCode = defaults.string(forKey: Keys.referralCode)
        self.signature = defaults.string(forKey: Keys.signature)
        self.languageCode = defaults.string(forKey: Keys.languageCode)
        
        colorSet = LightColorSet()
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

        defaults.removeObject(forKey: Keys.username)
        defaults.removeObject(forKey: Keys.token)
        defaults.removeObject(forKey: Keys.referralCode)
        
        // NotificationCenter.default.post(name: AppNotification.LOGOUT, object: nil)
    }

    
}

extension UserSettings {
    var color: ColorSet {
        return colorSet
    }
    
    func setColorScheme(_ option: ColorSchemeOption, systemColorScheme: ColorScheme = .light) {
        self.colorSchemeOption = option
        self.updateTheme(option, systemColorScheme: systemColorScheme)
    }

    private func updateTheme(_ option: ColorSchemeOption, systemColorScheme: ColorScheme = .light) {
        switch option {
        case .system:
            colorSet = systemColorScheme == .dark ? DarkColorSet() : LightColorSet()
        case .light:
            colorSet = LightColorSet()
        case .dark:
            colorSet = DarkColorSet()
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

