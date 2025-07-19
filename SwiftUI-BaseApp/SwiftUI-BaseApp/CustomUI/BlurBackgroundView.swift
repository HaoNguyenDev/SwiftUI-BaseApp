//
//  BlurBackgroundView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 19/7/25.
//

import SwiftUI

struct BlurBackgroundView: View {
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        ZStack {
            Image("launch_screen_image")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            BlurView(style: theme.colorSchemeOption == .dark ? .dark : .light) // .light, .dark, .extraLight...
                .ignoresSafeArea()
        }
    }
}
