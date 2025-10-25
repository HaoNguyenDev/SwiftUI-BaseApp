//
//  LogoutConfirmView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI
import SDWebImageSwiftUI

struct LogoutConfirmView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    private let kDragDismissThreshold: CGFloat = 100
    private let kMaxOffset: CGFloat = 400
    
    @State private var isShow: Bool = false
    @State private var offset: CGFloat = 400
    @State private var opacity: CGFloat = 0
    
    let onLogout: VoidResult?
    let onDismiss: VoidResult?
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                AnimatedImage(name: "ic_logout_animate.gif")
                    .resizable()
                    .frame(width: 120, height: 120)
                
                Text("logout_prompt".localized())
                    .boldStyle(theme, size: TextSize.title2, color: theme.color.primaryText)
                
                Text("logout_message".localized())
                    .regularStyle(theme, size: TextSize.callout, color: theme.color.primaryText)
                
                Button("logout".localized()) {
                    onLogout?()
                }
                .primaryHButton()
                
                Button("cancel".localized()) {
                    onDismiss?()
                }.secondaryHButton()
                
            }
            .padding(EdgeInsets(top: 40, leading: 32, bottom: 40, trailing: 32))
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(theme.color.secondaryBg)
            )
            .offset(y: offset)
            .opacity(opacity)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color.clear)
        .animation(.easeOut(duration: 0.2), value: offset)
        .animation(.easeOut(duration: 0.2), value: opacity)
        .onChange(of: isShow) { _, newValue in
            offset = newValue ? 0 : kMaxOffset
            opacity = newValue ? 1 : 0
        }
        .onAppear {
            // Add a slight delay to ensure the view is fully rendered
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isShow = true
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    LogoutConfirmView(onLogout: nil, onDismiss: nil)
        .environment(UserSettings())
        .background(Color.clear)
}
