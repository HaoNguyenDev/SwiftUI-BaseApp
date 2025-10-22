//
//  DarkThemeColors.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import UIKit
import SwiftUI

struct DarkThemeColors: ThemeColorProtocol {
    // Background
    var backgroundView: Color = R.color.backgroundView.color
    var bgColor = Color(hex: "#1C2526")
    var subviewBgColor = Color(hex: "#495051")
    var gradientBgColors = [Color(hex: "#4c4c4c"), Color(hex: "#000000")]
    
    // Text
    var textOnSubviewColor = Color(hex: "#ffffff")
    var textColor = Color(hex: "#ffffff")
    var errorMessage = Color(hex: "#cc0000")
    
    // Button
    var buttonBgColor = Color(hex: "#FFD700")
    var buttonBgDisableColor = Color(hex: "#FFD700").opacity(0.5)
    var buttonBgSelectedColor = Color(hex: "#FFD700")
    
    // Tab
    let mainTabSelectedTextColor = Color(hex: "#ffffff")
    let mainTabUnselectedTextColor =  Color(hex: "#AEAEB2")
}
