//
//  UserSettings.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import Foundation
import UIKit

final class UserSettings: ObservableObject {
    static let shared = UserSettings()
    
    private init() {
        colorSchemeOption = Preferences[.colorSchemeOption]
    }
    
    var username: String? {
        get {
            Preferences[.username]
        }
        set {
            Preferences[.username] = newValue
        }
    }
    
    var token: String? {
        get {
            Preferences[.userToken]
        }
        set {
            Preferences[.userToken] = newValue
        }
    }
    
    var hasLogin: Bool {
        return token != nil
    }
    
    var referralCode: String? {
        get {
            Preferences[.referralCode]
        }
        set {
            Preferences[.referralCode] = newValue
        }
    }
    
    @Published var colorSchemeOption: ColorSchemeOption {
        didSet {
            Preferences[.colorSchemeOption] = colorSchemeOption
        }
    }
    
    func logout() {
        username = nil
        token = nil
        referralCode = nil
        
//        NotificationCenter.default.post(
//            name: AppNotification.LOGOUT, object: nil
//        )
    }
    
}
