//
//  ColorSet.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

protocol ColorSet {
    var bgColor: Color { get }
    var cellBgColor: Color { get }
    var textOnCellColor: Color { get }
    var gradientBgColors: [Color] { get }
    var textColor: Color { get }
    var buttonBgColor: Color { get }
    var mainTabSelectedTextColor: Color { get }
    var mainTabUnselectedTextColor: Color { get }
}
