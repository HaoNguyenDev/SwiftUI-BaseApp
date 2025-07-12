//
//  ThemeManager.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("colorSchemeOption") var colorSchemeOption: ColorSchemeOption = .system {
        didSet {
            updateTheme(colorSchemeOption)
        }
    }
    @Published private var colorSet: ColorSet
    
    init() {
        self.colorSet = LightColorSet()
        updateTheme(colorSchemeOption)
    }
    
    func updateTheme(_ option: ColorSchemeOption, systemColorScheme: ColorScheme = .light) {
        switch option {
        case .system:
            colorSet = systemColorScheme == .dark ? DarkColorSet() : LightColorSet()
        case .light:
            colorSet = LightColorSet()
        case .dark:
            colorSet = DarkColorSet()
        }
    }
    
    var color: ColorSet {
        return colorSet
    }
}
