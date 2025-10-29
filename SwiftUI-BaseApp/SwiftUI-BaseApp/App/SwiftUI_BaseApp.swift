//
//  SwiftUI_BaseAppApp.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI
import Kingfisher

@main
struct SwiftUI_BaseApp: App {
    
    @State private var userSettings: UserSettings? = nil
    @State private var appSettings = AppSettings()
    @State private var appState = AppState()
    
    init() {}
    
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
    private var testUI: some View {
        ContentView()
            .environment(appState)
            .environment(appSettings)
            .environment(userSettings)
            .environmentTheme(manager: ThemeManager.shared)
    }
}
