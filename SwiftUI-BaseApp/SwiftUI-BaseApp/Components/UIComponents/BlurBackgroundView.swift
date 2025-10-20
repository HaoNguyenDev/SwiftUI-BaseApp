//
//  BlurBackgroundView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 19/7/25.
//

import SwiftUI

struct BlurBackgroundView: View {
    @Environment(UserSettings.self) var userSettings
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Image(R.image.launch_screen_image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            BlurView(style: userSettings.colorSchemeOption == .system ? (colorScheme == .dark ? .dark : .light) : userSettings.colorSchemeOption == .dark ? .dark : .light) // .light, .dark, .extraLight...
                .ignoresSafeArea()
        }
    }
}
