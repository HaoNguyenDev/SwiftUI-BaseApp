//
//  LightTheme.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation

struct LightTheme: ThemeProtocol {
    var color: ThemeColorProtocol = LightThemeColors()
    var font: ThemeFontProtocol = LightThemeFonts()
    var assets: ThemeAssetsProtocol = LightThemeAssets()
}
