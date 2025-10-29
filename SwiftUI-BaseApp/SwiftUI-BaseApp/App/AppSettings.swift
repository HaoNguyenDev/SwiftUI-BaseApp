//
//  AppSettings.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import Foundation
import Kingfisher

@Observable final class AppSettings {
    
    var appVersion: AppVersion?
    
    var isMaintenance: Bool { false }
    
    var isNeedUpdate: Bool {
        guard let appVersion = appVersion else { return false }
        let state = appVersion.checkUpdate(Env.shared.getVersionApp())
        return state != .nonUpdate
    }
    
    init(appVersion: AppVersion? = nil) {
        self.appVersion = appVersion
        setupDefaultSettings()
        setupKingfisherCache()
    }
    
    private func setupDefaultSettings() {
        Logger.shared.isEnabled = true
    }
    
    private func setupKingfisherCache() {
        let cache = ImageCache.default
        /// Limit the Memory Cache to 200 MB
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 200
        /// Limit the number of images in RAM to 200
        cache.memoryStorage.config.countLimit = 200
        /// Set the expiration time in RAM to 5 minutes (images will be released from RAM after 5 minutes of disuse)
        cache.memoryStorage.config.expiration = .seconds(60)
        /// Limit the disk cache to 500 MB
        cache.diskStorage.config.sizeLimit = 1024 * 1024 * 500
        /// Images expire on disk after 7 days
        cache.diskStorage.config.expiration = .days(7)
    }
}
