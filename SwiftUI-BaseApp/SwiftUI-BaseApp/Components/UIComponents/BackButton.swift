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
        HStack {
            Image(uiImage: theme.assets.iconBack)
                .renderingMode(.template)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(theme.color.textColor)
        }
        .foregroundColor(theme.color.textColor)
        .padding(.leading, 0)
    }
}

#Preview {
    BackButton()
        .environment(UserSettings())
        .environmentTheme(manager: ThemeManager.shared)
        .preferredColorScheme(.light)
        
}
