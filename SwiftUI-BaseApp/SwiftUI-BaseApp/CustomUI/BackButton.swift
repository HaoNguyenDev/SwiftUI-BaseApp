//
//  BackButton.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

struct BackButton: View {
    @Environment(UserSettings.self) var settings
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .frame(width: 25, height: 25)
                .background(
                    Circle()
                        .stroke(lineWidth: 1.5)
                        .fill(settings.color.textColor)
                        .frame(width: 30, height: 30)
                )
        }
        .foregroundColor(settings.color.textColor)
        .padding(.leading, 10)
    }
}

#Preview {
    BackButton()
        .environment(UserSettings.shared)
        
}
