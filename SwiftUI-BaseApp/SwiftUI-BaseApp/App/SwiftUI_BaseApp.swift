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
    
    init() {
        setupDefaultSettings()
        setupKingfisherCache()
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
    
    private func setupKingfisherCache() {
        let cache = ImageCache.default
        /// Limit the Memory Cache to 100 MB
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 100
        /// Limit the number of images in RAM to 50
        cache.memoryStorage.config.countLimit = 100
        /// Set the expiration time in RAM to 5 minutes (images will be released from RAM after 5 minutes of disuse)
        cache.memoryStorage.config.expiration = .seconds(300)
        /// Limit the disk cache to 500 MB
        cache.diskStorage.config.sizeLimit = 1024 * 1024 * 500
        /// Images expire on disk after 7 days
        cache.diskStorage.config.expiration = .days(7)
    }
    
    private var testUI: some View {
        ContentView()
            .environment(appState)
            .environment(appSettings)
            .environment(userSettings)
            .environmentTheme(manager: ThemeManager.shared)
    }
}
