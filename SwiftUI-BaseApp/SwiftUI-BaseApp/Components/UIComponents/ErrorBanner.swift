//
//  ErrorBanner.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//


import SwiftUI

struct ErrorBanner: View {
    @Environment(\.theme) var theme
    
    let error: Error?
    var retry: () -> Void
    var body: some View {
        HStack {
            if let networkError = error as? NetworkError {
                Text(networkError.errorDescription)
                    .regularStyle(theme, size: 17, color: theme.color.textColor)
            } else {
                Text(error?.localizedDescription ?? "Unknown error")
                    .regularStyle(theme, size: 17, color: theme.color.textColor)
            }
            Spacer()
            Button("Retry", action: retry)
        }
        .padding(12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(radius: 4)
    }
}
