//
//  LightThemeColors.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import UIKit
import SwiftUI

struct LightThemeColors: ThemeColorProtocol {
    // Background
    var backgroundView: Color = R.color.backgroundView.color
    var bgColor = Color(hex: "#ffffff")
    var subviewBgColor = Color(hex: "#333333")
    var gradientBgColors = [Color(hex: "#ffffff"), Color(hex: "#4C4CFF")]
    
    // Text
    var textOnSubviewColor = Color(hex: "#ffffff")
    var textColor = Color(hex: "#333333")
    var errorMessage = Color(hex: "#cc0000")
    
    // Button
    var buttonBgColor = Color(hex: "#007AFF")
    var buttonBgDisableColor = Color(hex: "#007AFF").opacity(0.5)
    var buttonBgSelectedColor = Color(hex: "#006de5")
    
    // Tab
    let mainTabSelectedTextColor = Color(hex: "#ffffff")
    let mainTabUnselectedTextColor =  Color(hex: "#AEAEB2")
}
