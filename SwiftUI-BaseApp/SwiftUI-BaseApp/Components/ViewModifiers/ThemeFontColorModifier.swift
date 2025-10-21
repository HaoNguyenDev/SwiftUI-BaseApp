//
//  ThemeFontColorModifier.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 21/10/25.
//


import SwiftUI

// MARK: - View Modifier
struct ThemeFontColorModifier: ViewModifier {
    var font: Font
    var color: Color
    var alignment: TextAlignment = .leading
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(color)
            .multilineTextAlignment(alignment)
    }
}

extension Text {
    func textStyle(
        font: Font,
        color: Color,
        alignment: TextAlignment = .leading
    ) -> some View {
        modifier(ThemeFontColorModifier(font: font, color: color, alignment: alignment))
    }
    
    // MARK: - PRIMARY STYLES
    
    func regularStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.regular(ofSize: size), color: color, alignment: alignment)
    }
    
    func boldStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.bold(ofSize: size), color: color, alignment: alignment)
    }
    
    func mediumStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.medium(ofSize: size), color: color, alignment: alignment)
    }

    func semiboldStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.semibold(ofSize: size), color: color, alignment: alignment)
    }
    
    func heavyStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.heavy(ofSize: size), color: color, alignment: alignment)
    }

    func lightStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.light(ofSize: size), color: color, alignment: alignment)
    }

    func thinStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.thin(ofSize: size), color: color, alignment: alignment)
    }

    func ultralightStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.ultralight(ofSize: size), color: color, alignment: alignment)
    }
    
    // MARK: - SECONDARY STYLES
    
    func regularSecondaryStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.regularSecondary(ofSize: size), color: color, alignment: alignment)
    }
    
    func boldSecondaryStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.boldSecondary(ofSize: size), color: color, alignment: alignment)
    }
    
    func mediumSecondaryStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.mediumSecondary(ofSize: size), color: color, alignment: alignment)
    }
    
    func semiBoldSecondaryStyle(_ theme: ThemeProtocol, size: CGFloat, color: Color, alignment: TextAlignment = .leading) -> some View {
        return textStyle(font: theme.font.semiBoldSecondary(ofSize: size), color: color, alignment: alignment)
    }
}
