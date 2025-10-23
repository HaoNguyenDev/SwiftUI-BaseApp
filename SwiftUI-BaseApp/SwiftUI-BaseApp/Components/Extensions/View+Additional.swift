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
    @Environment(\.theme) var theme: any ThemeProtocol
    func body(content: Content) -> some View {
        content
            .background(
                ContainerRelativeShape()
                    .fill(theme.color.primaryBg)
                    .ignoresSafeArea(edges: .all)
            )
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

// MARK: Modifiers
struct BackgroundImageModifier: ViewModifier {
    @Environment(\.theme) var theme: any ThemeProtocol
    func body(content: Content) -> some View {
        content
            .background(
                theme.color.subviewBgColor.opacity(0.8) //Transparent color class
                    .overlay(BlurBackgroundView())
            )
        
        
    }
}

// MARK: - RoundedCorner
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        return Path(path.cgPath)
    }
}

extension View {
    func roundCorners(
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func roundedBorder(
        cornerRadius: CGFloat,
        lineWidth: CGFloat = 1,
        borderColor: Color = .clear
    ) -> some View {
        overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: lineWidth)
        )
    }
}
