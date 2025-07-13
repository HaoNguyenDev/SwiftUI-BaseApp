//
//  DarkColorSet.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

struct DarkColorSet: ColorSet {
    let bgColor = Color(hex: "#1C2526")
    let subviewBgColor = Color(hex: "#495051")
    var textSubviewColor = Color(hex: "#ffffff")
    let gradientBgColors = [Color(hex: "#4c4c4c"), Color(hex: "#000000")]
    let textColor = Color(hex: "#ffffff")
    let buttonBgColor = Color(hex: "#FFD700")
    let mainTabSelectedTextColor: Color = Color(hex: "#000000")
    let mainTabUnselectedTextColor: Color = Color(hex: "#AEAEB2")
}
