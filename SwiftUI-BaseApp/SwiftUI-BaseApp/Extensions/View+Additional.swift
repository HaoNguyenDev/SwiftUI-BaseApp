//
//  View+Additional.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

extension View {
    func setDefaultBackground() -> some View {
        modifier(BackgroundModifier())
    }
    
    func setGradientBackground(rotationColor: Bool = false) -> some View {
        modifier(GradientBackgroundModifier(rotationColor: rotationColor))
    }
    
    func setBlurBackgroundImage() -> some View {
        modifier(BackgroundImageModifier())
    }
}

// MARK: Modifiers
struct BackgroundModifier: ViewModifier {
    @EnvironmentObject var theme: ThemeManager
    func body(content: Content) -> some View {
        content
            .background(
                ContainerRelativeShape()
                    .fill(theme.color.bgColor)
                    .ignoresSafeArea(edges: .all)
            )
    }
}

struct GradientBackgroundModifier: ViewModifier {
    @EnvironmentObject var theme: ThemeManager
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

// MARK: Modifiers
struct BackgroundImageModifier: ViewModifier {
    @EnvironmentObject var theme: ThemeManager
    func body(content: Content) -> some View {
        content
            .background(
                theme.color.subviewBgColor.opacity(0.8) // Lớp màu trong suốt
                    .overlay(BlurBackgroundView())
            )
        
        
    }
}
