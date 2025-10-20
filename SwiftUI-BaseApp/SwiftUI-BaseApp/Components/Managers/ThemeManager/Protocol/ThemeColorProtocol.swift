//
//  ThemeColorProtocol.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation
import SwiftUI

protocol ThemeColorProtocol {
    var bgColor: Color { get }
    var subviewBgColor: Color { get }
    var textOnSubviewColor: Color { get }
    var gradientBgColors: [Color] { get }
    var textColor: Color { get }
    var buttonBgColor: Color { get }
    var mainTabSelectedTextColor: Color { get }
    var mainTabUnselectedTextColor: Color { get }
}
