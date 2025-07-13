//
//  LoadingView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI


#Preview {
    TestLoadingView()
        .environmentObject(ThemeManager())
}

struct TestLoadingView: View {
    var body: some View {
        VStack {
            LoadingView(hideText: false)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setDefaultBackground()
    }
}

struct LoadingView: View {
    @EnvironmentObject var theme: ThemeManager
    @State private var isAnimating = false
    private let dotCount = 6
    private let radius: CGFloat = 30
    var hideText: Bool = false

    var body: some View {
        ZStack {
            ForEach(0..<dotCount, id: \.self) { index in
                Circle()
                    .fill(theme.color.textSubviewColor)
                    .frame(width: 10, height: 10)
                    .offset(x: radius)
                    .rotationEffect(.degrees(Double(index) / Double(dotCount) * 360))
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(
                        Animation
                            .easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: false)
                            .delay(Double(index) * 0.05),
                        value: isAnimating
                    )
            }
            
            if !hideText {
                VStack {
                    Text("Please wait a moment...")
                        .font(mainFont.bold(17))
                        .foregroundColor(theme.color.textColor)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 120)
            }
        }
        
        
        .onAppear {
            isAnimating = true
        }
    }
}
