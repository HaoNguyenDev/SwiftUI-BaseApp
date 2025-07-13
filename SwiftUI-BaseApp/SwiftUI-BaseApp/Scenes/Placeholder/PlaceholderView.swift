//
//  PlaceholderView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

struct PlaceholderView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var newTitle: String?
    var defaultTitle: String = "In development"
    var message: String = "This feature will be updated soon."
    var onClose: (() -> Void)?

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "hammer.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.orange)

            if let newTitle = newTitle {
                Text("\(newTitle)\nis in development")
                    .font(mainFont.bold(30))
                    .foregroundStyle(themeManager.color.textColor)
                    .multilineTextAlignment(.center)
            } else {
                Text(defaultTitle)
                    .font(mainFont.bold(30))
                    .foregroundStyle(themeManager.color.textColor)
                    .multilineTextAlignment(.center)
            }
            
            Text(message)
                .font(mainFont.regular(20))
                .multilineTextAlignment(.center)
                .foregroundStyle(themeManager.color.textColor)
            
            Spacer()
                .frame(height: 20)
            Capsule()
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 100, height: 60, alignment: .center)
                .foregroundStyle(themeManager.color.textColor)
                .background(
                    Button {
                        onClose?()
                    } label: {
                        Text("Allright")
                            .font(mainFont.bold(18))
                            .foregroundStyle(themeManager.color.textColor)
                    }
                )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setDefaultBackground()
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
