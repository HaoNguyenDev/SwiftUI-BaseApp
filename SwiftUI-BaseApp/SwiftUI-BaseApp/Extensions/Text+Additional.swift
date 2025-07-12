//
//  Text+Additional.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

extension Text {
    func set(font: Font, and color: Color) -> some View {
        modifier(FontAndColor(font: font, color: color))
    }
}

// MARK: Modifiers
struct FontAndColor: ViewModifier {
    let font: Font
    let color: Color
    
    init(font: Font, color: Color) {
        self.font = font
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(color)
    }
}
