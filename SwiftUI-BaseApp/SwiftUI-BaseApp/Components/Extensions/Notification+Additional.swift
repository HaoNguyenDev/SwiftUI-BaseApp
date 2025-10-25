//
//  Notification+Additional.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import Foundation

extension Notification.Name {
    static let showNotificationScreen = Notification.Name("showNotificationScreen")
    static let showSettingsScreen = Notification.Name("showSettingsScreen")
    static let showHomeScreen = Notification.Name("showHomeScreen")
    static let showProfileScreen = Notification.Name("showProfileScreen")
    static let logout = NSNotification.Name(rawValue: "logout")
}
