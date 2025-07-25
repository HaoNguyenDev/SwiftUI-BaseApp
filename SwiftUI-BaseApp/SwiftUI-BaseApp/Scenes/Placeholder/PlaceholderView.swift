//
//  PlaceholderView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

import SwiftUI

struct PlaceholderView: View {
    @EnvironmentObject var settings: UserSettings
    var newTitle: String?
    var onClose: (() -> Void)?

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "hammer")
                .resizable()
                .scaledToFit()
                .symbolEffect(.wiggle)
                .frame(width: 80, height: 80)
                .foregroundColor(settings.color.textColor)

            if let newTitle = newTitle {
                Text("\(newTitle)\n\("in_development".localized())")
                    .setFont(.bold, size: 30.0,
                             color: settings.color.textColor,
                             alignment: .center)
            } else {
                Text("in_development".localized())
                    .setFont(.bold, size: 30.0,
                             color: settings.color.textColor,
                             alignment: .center)
            }
            
            Text("feature_update_soon".localized())
                .setFont(.regular, size: 20.0,
                         color: settings.color.textColor,
                         alignment: .center)
            
            Spacer()
                .frame(height: 20)
            Capsule()
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 100, height: 60, alignment: .center)
                .foregroundStyle(settings.color.textColor)
                .background(
                    Button {
                        onClose?()
                    } label: {
                        Text("all_right".localized())
                            .setFont(.bold, size: 18.0,
                                     color: settings.color.textColor,
                                     alignment: .center)
                    }
                )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setBlurBackgroundImage()
    }
}


#Preview {
    PlaceholderView()
        .environmentObject(UserSettings.shared)
}

