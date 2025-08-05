//
//  LogoutConfirmView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI
import SDWebImageSwiftUI

struct LogoutConfirmView: View {
    @Environment(UserSettings.self) private var userSettings
    private let kDragDismissThreshold: CGFloat = 100
    private let kMaxOffset: CGFloat = 400
    
    @State private var isShow: Bool = false
    @State private var offset: CGFloat = 400
    @State private var opacity: CGFloat = 0
    
    let onDismiss: VoidResult?
    let onLogout: VoidResult?
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                AnimatedImage(name: "ic_logout_animate.gif")
                    .resizable()
                    .frame(width: 120, height: 120)
                
                Text("logout_prompt".localized())
                    .setFont(.bold, size: 24, color: userSettings.color.textOnSubviewColor)
                
                Text("logout_message".localized())
                    .setFont(.regular, size: 14, color: userSettings.color.textOnSubviewColor)
                
                Button {
                    onLogout?()
                } label: {
                    Text("logout".localized())
                        .setFont(.bold, size: 17, color: userSettings.color.textOnSubviewColor)
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(userSettings.color.textOnSubviewColor)
                        )
                }
                
                
                Button {
                    onDismiss?()
                } label: {
                    Text("cancel".localized())
                        .setFont(.bold, size: 17, color: userSettings.color.textOnSubviewColor)
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(userSettings.color.textOnSubviewColor)
                        )
                }
               
            }
            .padding(EdgeInsets(top: 40, leading: 32, bottom: 40, trailing: 32))
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(userSettings.color.subviewBgColor)
            )
            .offset(y: offset)
            .opacity(opacity)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .setBlurBackgroundImage()
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
    LogoutConfirmView(onDismiss: nil, onLogout: nil)
        .environment(UserSettings())
}
