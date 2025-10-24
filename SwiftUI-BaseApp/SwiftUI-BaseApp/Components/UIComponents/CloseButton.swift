//
//  CloseButton.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    private var iconSize: CGFloat = 50.0
    var action: VoidResult
    
    init(iconSize: CGFloat = 50.0, action: @escaping VoidResult) {
        self.iconSize = iconSize
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            icon
        }
        .buttonStyle(.plain)
    }
    
    private var icon: some View {
        let image = theme.assets.iconClose.withRenderingMode(.alwaysTemplate)
        
        return Image(uiImage: image)
            .foregroundStyle(theme.color.primaryText)
            .iconStyle(
                width: iconSize,
                height: iconSize,
                mode: .fit,
                radius: 0,
                border: 0,
                borderColor: .clear
            )
    }
}

#Preview {
    CloseButton(action: {})
        .environmentTheme(manager: ThemeManager.shared)
        .preferredColorScheme(.light)
    
}
