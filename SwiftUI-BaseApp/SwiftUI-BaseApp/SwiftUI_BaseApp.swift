//
//  SwiftUI_BaseAppApp.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

@main
struct SwiftUI_BaseApp: App {
    
    @State private var userSettings = UserSettings()
    @State private var appSettings = AppSettings()
    @State private var appState = AppState()
    @State private var languageManager = LanguageManager()
    
    init() {
        setupDefaultSettings()
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator()
                .environment(appState)
                .environment(appSettings)
                .environment(userSettings)
                .environment(languageManager)
        }
    }
}

extension SwiftUI_BaseApp {
    private func setupDefaultSettings() {
        Logger.shared.isEnabled = true
        Logger.shared.info("Language: \(userSettings.languageCode ?? "")")
        Logger.shared.info("Theme mode: \(userSettings.colorSchemeOption)")
    }
}
