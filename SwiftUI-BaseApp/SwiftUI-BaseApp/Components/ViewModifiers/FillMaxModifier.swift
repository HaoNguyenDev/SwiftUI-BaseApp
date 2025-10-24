//
//  FillMaxModifier.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//


import SwiftUI

extension View {
    func fillMax() -> some View {
        self.modifier(FillMaxModifier())
    }
}

struct FillMaxModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
    }
}
