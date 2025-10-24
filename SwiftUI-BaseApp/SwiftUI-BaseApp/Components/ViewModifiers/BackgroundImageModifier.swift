//
//  BackgroundImageModifier.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//
import SwiftUI

extension View {
    func setBlurBackgroundImage() -> some View {
        modifier(BackgroundImageModifier())
    }
}

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
