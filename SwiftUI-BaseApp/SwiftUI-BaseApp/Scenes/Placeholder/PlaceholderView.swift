//
//  PlaceholderView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

import SwiftUI

struct PlaceholderView: View {
    @EnvironmentObject var theme: ThemeManager
    var newTitle: String?
    var defaultTitle: String = "in_development".localized()
    var message: String = "feature_update_soon".localized()
    var onClose: (() -> Void)?

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "hammer")
                .resizable()
                .scaledToFit()
                .symbolEffect(.wiggle)
                .frame(width: 80, height: 80)
                .foregroundColor(theme.color.textColor)

            if let newTitle = newTitle {
                Text("\(newTitle)\n\(defaultTitle)")
                    .font(mainFont.bold(30))
                    .foregroundStyle(theme.color.textColor)
                    .multilineTextAlignment(.center)
            } else {
                Text(defaultTitle)
                    .font(mainFont.bold(30))
                    .foregroundStyle(theme.color.textColor)
                    .multilineTextAlignment(.center)
            }
            
            Text(message)
                .font(mainFont.regular(20))
                .multilineTextAlignment(.center)
                .foregroundStyle(theme.color.textColor)
            
            Spacer()
                .frame(height: 20)
            Capsule()
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 100, height: 60, alignment: .center)
                .foregroundStyle(theme.color.textColor)
                .background(
                    Button {
                        onClose?()
                    } label: {
                        Text("all_right".localized())
                            .font(mainFont.bold(18))
                            .foregroundStyle(theme.color.textColor)
                    }
                )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setDefaultBackground()
    }
}


#Preview {
    PlaceholderView()
        .environmentObject(ThemeManager())
}

