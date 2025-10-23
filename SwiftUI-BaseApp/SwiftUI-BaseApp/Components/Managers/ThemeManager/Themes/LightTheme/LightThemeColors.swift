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
    
    //--------------------//---------------------//
    
    // Background
    var primaryBg: Color = Color(hex: "#feffff")
    var secondaryBg: Color = Color(hex: "#f9f9f9")
    
    // Shadow
    var primaryShadow: Color = Color(hex: "#171a1f").opacity(0.25)
    
    // Text
    var primaryText: Color = Color(hex: "#000000")
    var secondaryText: Color = Color(hex: "#757575")
    var secondaryText2: Color = Color(hex: "#9b9b9b")
    var highlightText: Color = Color(hex: "#efb80b")
    
    // Button
    var buttonPrimaryBg: Color = Color(hex: "#fbd535")
    var buttonPrimarySelectedBg: Color = Color(hex: "#f2c756")
    var buttonPrimaryDisabledBg: Color = Color(hex: "#fbd535").opacity(0.5)
    var buttonPrimaryTitle: Color = Color(hex: "#202530")
    var buttonPrimaryBoder: Color = Color.clear
    
    var buttonSecondaryBg: Color = Color(hex: "#d4d4d4")
    var buttonSecondarySelectedBg: Color = Color(hex: "#d4d4d4")
    var buttonSecondaryDisabledBg: Color = Color(hex: "#ececec").opacity(0.5)
    var buttonSecondaryTitle: Color = Color(hex: "#040404")
    var buttonSecondaryBoder: Color = Color.clear
    
    var buttonTertiaryBg: Color =  Color.clear
    var buttonTertiarySelectedBg: Color = Color(hex: "#ececec")
    var buttonTertiaryDisabledBg: Color = Color(hex: "#ececec").opacity(0.5)
    var buttonTertiaryTitle: Color = Color(hex: "#040404")
    var buttonTertiaryBoder: Color = Color(hex: "#040404")
}
