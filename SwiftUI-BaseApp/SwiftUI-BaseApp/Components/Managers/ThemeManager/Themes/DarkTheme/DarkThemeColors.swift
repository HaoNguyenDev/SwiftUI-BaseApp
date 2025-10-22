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
    
    //--------------------//---------------------//
    
    // Background
    var primaryBg: Color = Color(hex: "#171a1f")
    var secondaryBg: Color = Color(hex: "#28303d")
    
    // Text
    var primaryText: Color = Color(hex: "#e9ebee")
    var secondaryText: Color = Color(hex: "#9299a4")
    var secondaryText2: Color = Color(hex: "#707a8a")
    var highlightText: Color = Color(hex: "#efb80b")
    
    // Button
    var buttonPrimaryBg: Color = Color(hex: "#fbd535")
    var buttonPrimarySelectedBg: Color = Color(hex: "#f2c756")
    var buttonPrimaryDisabledBg: Color = Color(hex: "#fbd535").opacity(0.5)
    var buttonPrimaryTitle: Color = Color(hex: "#202530")
    
    var buttonSecondaryBg: Color = Color(hex: "#333b47")
    var buttonSecondarySelectedBg: Color = Color(hex: "#5b626b")
    var buttonSecondaryDisabledBg: Color = Color(hex: "#333b47").opacity(0.5)
    var buttonSecondaryTitle: Color = Color(hex: "#e9ebee")
    
}
