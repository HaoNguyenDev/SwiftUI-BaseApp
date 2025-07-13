//
//  AppSettings.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import Foundation

final class AppSettings: ObservableObject {
    static let shared = AppSettings()
    private init() {}
    
    var appVersion: AppVersion?
    
    var isMaintenance: Bool { false }
    
    var isNeedUpdate: Bool {
        return true
//        guard let appVersion = appVersion else { return false }
//        let state = appVersion.checkUpdate(Env.shared.getVersionApp())
//        return state != .nonUpdate
    }
}
