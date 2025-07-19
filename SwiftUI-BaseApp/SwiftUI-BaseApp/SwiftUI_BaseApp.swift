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
    @StateObject private var appState = AppState()
    @StateObject private var themeManager = ThemeManager()
    
    init() {
        setDefaultLanguage()
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator()
                .environmentObject(AppSettings.shared)
                .environmentObject(userSettings)
                .environmentObject(appState)
                .environmentObject(themeManager)
        }
    }
}

extension SwiftUI_BaseApp {
    func setDefaultLanguage() {
        AppSetupUtilities.setLanguage(LanguageManager.shared.language)
    }
}
