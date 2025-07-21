//
//  SwiftUI_BaseAppApp.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

@main
struct SwiftUI_BaseApp: App {
    
    @StateObject private var userSettings = UserSettings.shared
    @StateObject private var appSettings = AppSettings.shared
    @StateObject private var appState = AppState()
    
    init() {
        setupDefaultSettings()
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator()
                .environmentObject(appState)
                .environmentObject(appSettings)
                .environmentObject(userSettings)
        }
    }
}

extension SwiftUI_BaseApp {
    private func setupDefaultSettings() {
        Logger.shared.isEnabled = true
        Logger.shared.debug("\(UserSettings.shared.userLanguageCode)")
    }
}
