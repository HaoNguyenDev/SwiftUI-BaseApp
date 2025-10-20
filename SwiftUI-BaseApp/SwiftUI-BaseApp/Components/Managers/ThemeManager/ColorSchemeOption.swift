//
//  ColorSchemeOption.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

enum ColorSchemeOption: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    
    var title: String {
        switch self {
        case .system:
            return "system".localized()
        case .light:
            return "light".localized()
        case .dark:
            return "dark".localized()
        }
    }
}
