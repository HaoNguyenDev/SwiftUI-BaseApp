//
//  BackButton.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    var body: some View {
        VStack {
            Image(uiImage: theme.assets.iconBack)
                .foregroundStyle(theme.color.primaryText)
                .iconStyle(
                    width: 30,
                    height: 50,
                    mode: .fit,
                    radius: 0,
                    border: 0,
                    color: .clear
                )
        }
    }
}

#Preview {
    BackButton()
        .environment(UserSettings())
        .environmentTheme(manager: ThemeManager.shared)
        .preferredColorScheme(.light)
        
}
