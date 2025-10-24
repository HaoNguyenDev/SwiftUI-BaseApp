//
//  GradientBackgroundModifier.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//

import SwiftUI

extension View {
    
    func setGradientBackground(rotationColor: Bool = false) -> some View {
        modifier(GradientBackgroundModifier(rotationColor: rotationColor))
    }
}

struct GradientBackgroundModifier: ViewModifier {
    @Environment(\.theme) var theme: any ThemeProtocol
    var rotationColor: Bool = false
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: getBackgroundColor(rotationColor: rotationColor) ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
    
    private func getBackgroundColor(rotationColor: Bool = false) -> [Color] {
        return rotationColor ? theme.color.gradientBgColors.reversed() : theme.color.gradientBgColors
    }
}
