//
//  ThemeManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import SwiftUI

@Observable class ThemeManager {
    static var shared = ThemeManager()
    
    var currentTheme: any ThemeProtocol = LightTheme()
    
    var isDarkEnabled: Bool = false {
        didSet {
            currentTheme = isDarkEnabled ? DarkTheme() : LightTheme()
        }
    }
    
    private init() {}
}
