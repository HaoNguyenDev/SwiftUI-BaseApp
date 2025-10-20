//
//  SwiftUI_BaseAppApp.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

@main
struct SwiftUI_BaseApp: App {
    
    @State private var userSettings: UserSettings? = nil
    @State private var appSettings = AppSettings()
    @State private var appState = AppState()
    
    init() {
        setupDefaultSettings()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if let userSettings = userSettings {
                    AppCoordinator()
                        .environment(appState)
                        .environment(appSettings)
                        .environment(userSettings)
                        .environmentTheme(manager: ThemeManager.shared)
                } else {
                    SampleLoadingView(title: "please_wait".localized())
                }
            }
            .task {
                userSettings = await UserSettings.loadSettings()
            }
        }
    }
}

extension SwiftUI_BaseApp {
    private func setupDefaultSettings() {
        Logger.shared.isEnabled = true
        Logger.shared.info("Language: \(userSettings?.languageCode ?? "")")
        Logger.shared.info("Theme mode: \(String(describing: userSettings?.colorSchemeOption))")
    }
}
