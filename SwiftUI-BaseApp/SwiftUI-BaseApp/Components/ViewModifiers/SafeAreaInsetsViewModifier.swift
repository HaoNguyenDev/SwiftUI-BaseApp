//
//  SafeAreaInsetsViewModifier.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 27/10/25.
//

import SwiftUI

extension View {
    func safeAreaInsetsViewModifier(verticalEdge: VerticalEdge, viewHeight: CGFloat = 120.0, viewColor: Color? = Color.clear) -> some View {
        self.modifier(SafeAreaInsetsViewModifier(verticalEdge: verticalEdge, viewHeight: viewHeight, viewColor: viewColor))
    }
}

struct SafeAreaInsetsViewModifier: ViewModifier {
    let verticalEdge: VerticalEdge
    let viewHeight: CGFloat
    let viewColor: Color?
    
    init(verticalEdge: VerticalEdge, viewHeight: CGFloat, viewColor: Color? = Color.clear) {
        self.verticalEdge = verticalEdge
        self.viewHeight = viewHeight
        self.viewColor = viewColor
    }
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: verticalEdge) {
                viewColor
                    .frame(height: viewHeight)
                    .background(.clear)
            }
    }
}
