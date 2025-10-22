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
}
