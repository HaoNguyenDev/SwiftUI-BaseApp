//
//  PrimaryBackgroundModifier.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//

import SwiftUI

extension View {
    func setPrimaryBackground() -> some View {
        modifier(PrimaryBackgroundModifier())
    }
}
// MARK: Modifiers
struct PrimaryBackgroundModifier: ViewModifier {
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
