//
//  DarkThemeColors.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import UIKit
import SwiftUI

struct DarkThemeColors: ThemeColorProtocol {
    let bgColor = Color(hex: "#1C2526")
    let subviewBgColor = Color(hex: "#495051")
    var textOnSubviewColor = Color(hex: "#ffffff")
    let gradientBgColors = [Color(hex: "#4c4c4c"), Color(hex: "#000000")]
    let textColor = Color(hex: "#ffffff")
    let buttonBgColor = Color(hex: "#FFD700")
    let mainTabSelectedTextColor: Color = Color(hex: "#ffffff")
    let mainTabUnselectedTextColor: Color = Color(hex: "#AEAEB2")
}
