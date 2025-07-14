//
//  LightColorSet.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

struct LightColorSet: ColorSet {
    let bgColor = Color(hex: "#ffffff")
    let subviewBgColor = Color(hex: "#333333")
    var textOnSubviewColor = Color(hex: "#ffffff")
    let gradientBgColors = [Color(hex: "#ffffff"), Color(hex: "#4C4CFF")]
    let textColor = Color(hex: "#333333")
    let buttonBgColor = Color(hex: "#007AFF")
    let mainTabSelectedTextColor = Color(hex: "#ffffff")
    let mainTabUnselectedTextColor =  Color(hex: "#AEAEB2")
}
