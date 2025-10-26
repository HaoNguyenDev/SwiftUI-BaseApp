//
//  BackButton.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    let action: VoidResult?
    
    init(action: VoidResult? = nil) {
        self.action = action
    }
    var body: some View {
        VStack {
            Image(uiImage: theme.assets.iconBack.withRenderingMode(.alwaysTemplate))
                .foregroundStyle(theme.color.primaryText)
                .iconStyle(
                    width: 30,
                    height: 50,
                    mode: .fit,
                    radius: 0,
                    border: 0,
                    borderColor: .clear
                )
        }
        .onTapGesture {
            action?()
        }
    }
}

#Preview {
    BackButton(action: {
        
    })
        .environment(UserSettings())
        .environmentTheme(manager: ThemeManager.shared)
        .preferredColorScheme(.light)
        
}
