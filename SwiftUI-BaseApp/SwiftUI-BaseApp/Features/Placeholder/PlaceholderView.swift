//
//  PlaceholderView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

struct PlaceholderView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(\.dismiss) private var dismiss
    var newTitle: String?
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
                Text("\(newTitle)\n\("in_development".localized())")
                    .setFont(.bold, size: 30.0,
                             color: theme.color.textColor,
                             alignment: .center)
            } else {
                Text("in_development".localized())
                    .setFont(.bold, size: 30.0,
                             color: theme.color.textColor,
                             alignment: .center)
            }
            
            Text("feature_update_soon".localized())
                .setFont(.regular, size: 20.0,
                         color: theme.color.textColor,
                         alignment: .center)
            
            Spacer()
                .frame(height: 20)

            Button {
                dismiss()
                //onClose?()
            } label: {
                Text("all_right".localized())
                    .setFont(.bold, size: 18.0,
                             color: theme.color.textColor,
                             alignment: .center)
                    .padding()
                    .frame(height: 50)
            }.buttonStyle(SecondaryButtonStyle())
                
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setDefaultBackground()
    }
}


#Preview {
    PlaceholderView()
        .environment(UserSettings())
}

