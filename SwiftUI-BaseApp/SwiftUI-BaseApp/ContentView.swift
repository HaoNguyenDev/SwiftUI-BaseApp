//
//  ContentView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.theme) var theme
    
    var body: some View {
        ScrollView {
            VStack {
                Button("Primary") {
                    Logger.shared.debug("Primary")
                }
                .buttonStyle(.primaryHButtonStyle(size: .large))
                
                Button("Secondary") {
                    Logger.shared.debug("Secondary")
                }
                .buttonStyle(.secondaryHButtonStyle(size: .large))
                
                Button("Tertiary") {
                    Logger.shared.debug("Tertiary")
                }
                .buttonStyle(.tertiaryHButtonStyle(size: .large))
            }
            .padding()
        }
        .setPrimaryBackground()
    }
    
}

#Preview {
    ContentView()
        .environmentTheme(manager: ThemeManager.shared)
}
