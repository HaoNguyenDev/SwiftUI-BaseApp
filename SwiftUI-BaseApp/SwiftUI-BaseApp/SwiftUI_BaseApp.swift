//
//  SwiftUI_BaseAppApp.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

@main
struct SwiftUI_BaseApp: App {
    
    @State private var userSettings = UserSettings.shared
    @State private var appSettings = AppSettings.shared
    @State private var appState = AppState()
    
    init() {
        setupDefaultSettings()
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator()
                .environment(appState)
                .environment(appSettings)
                .environment(userSettings)
        }
    }
}

extension SwiftUI_BaseApp {
    private func setupDefaultSettings() {
        Logger.shared.isEnabled = true
        Logger.shared.debug("\(UserSettings.shared.userLanguageCode)")
    }
}
