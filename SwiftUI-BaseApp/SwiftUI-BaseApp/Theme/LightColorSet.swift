//
//  LightColorSet.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

struct LightColorSet: ColorSet {
    let bgColor = Color(hex: "#FFFFFF")
    let cellBgColor = Color(hex: "#1C2526")
    var textOnCellColor = Color(hex: "FFFFFF")
    let gradientBgColors = [Color(hex: "FFFFFF"), Color(hex: "#4C4CFF")]
    let textColor = Color(hex: "#000000")
    let buttonBgColor = Color(hex: "#007AFF")
    let mainTabSelectedTextColor = Color(hex: "FFFFFF")
    let mainTabUnselectedTextColor =  Color(hex: "#AEAEB2")
}
