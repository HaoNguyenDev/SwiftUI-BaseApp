//
//  ThemeColorProtocol.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation
import SwiftUI

protocol ThemeColorProtocol {
    // Background
    var backgroundView: Color { get }
    var bgColor: Color { get }
    var subviewBgColor: Color { get }
    var gradientBgColors: [Color] { get }
    
    // Text
    var textOnSubviewColor: Color { get }
    var textColor: Color { get }
    var errorMessage: Color { get }
    
    // Button
    var buttonBgColor: Color { get }
    var buttonBgDisableColor: Color { get }
    var buttonBgSelectedColor: Color { get }
    // Tab
    var mainTabSelectedTextColor: Color { get }
    var mainTabUnselectedTextColor: Color { get }
    
    //--------------------//---------------------//
    
    // Background
    var primaryBg: Color { get }
    var secondaryBg: Color { get }
    
    // Text
    var primaryText: Color { get }
    var secondaryText: Color { get }
    var secondaryText2: Color { get }
    var highlightText: Color { get }
    
    // Button
    var buttonPrimaryBg: Color { get }
    var buttonPrimarySelectedBg: Color { get }
    var buttonPrimaryDisabledBg: Color { get }
    var buttonPrimaryTitle: Color { get }
    var buttonPrimaryBoder: Color { get }
    
    var buttonSecondaryBg: Color { get }
    var buttonSecondarySelectedBg: Color { get }
    var buttonSecondaryDisabledBg: Color { get }
    var buttonSecondaryTitle: Color { get }
    var buttonSecondaryBoder: Color { get }
    
    var buttonTertiaryBg: Color { get }
    var buttonTertiarySelectedBg: Color { get }
    var buttonTertiaryDisabledBg: Color { get }
    var buttonTertiaryTitle: Color { get }
    var buttonTertiaryBoder: Color { get }
}
