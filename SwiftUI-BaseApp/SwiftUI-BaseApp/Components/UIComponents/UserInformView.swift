//
//  UserInformView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

struct InformAction {
    let title: String
    let callback: VoidResult?
}

struct UserInformView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    let message: UserMessageItem
    
    @State private var isShow: Bool = false
    private var primaryAction: InformAction?
    private var secondaryAction: InformAction?
    
    init(message: UserMessageItem, primaryAction: InformAction? = nil, secondaryAction: InformAction? = nil) {
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        
    }
    
    var body: some View {
        VStack {
            VStack {
                if let icon = message.icon {
                    Image(uiImage: icon)
                        .resizable()
                        .frame(width: 120, height: 120)
                } else if message.animation != nil {
                    LoadingView(hideText: true, loadingOnSubview: true)
                        .frame(width: 100, height: 100)
                    //                    LottieHelperView(fileName: animation.name, playLoopMode: animation.loop)
                    //                        .frame(width: 120, height: 120)
                }
                
                VStack(spacing: 16) {
                    if let title = message.title {
                        Text(title)
                            .boldStyle(theme, size: AppTextStyleSize.title2, color: message.type.color)
                    }
                    if let message = message.message {
                        Text(message)
                            .regularStyle(theme, size: AppTextStyleSize.callout, color: theme.color.primaryText)
                            .fixedSize(horizontal: false, vertical: true)
                    } else if let attributeMessage = message.attributeMessage {
                        Text(attributeMessage)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    VStack(spacing: 16) {
                        // Primary action
                        if let primaryAction {
                            Button(action: {
                                primaryAction.callback?()
                            },
                                   label: {
                                Text(primaryAction.title)
                                    .boldStyle(theme, size: AppTextStyleSize.subhead, color: theme.color.textOnSubviewColor)
                                    .frame(height: 48)
                                    .frame(maxWidth: .infinity)
                            })
                            .buttonStyle(.primaryHButtonStyle(size: .large))
                        }
                        
                        // Secondary action
                        if let secondaryAction {
                            Button(action: {
                                secondaryAction.callback?()
                            },
                                   label: {
                                Text(secondaryAction.title)
                                    .regularStyle(theme, size: AppTextStyleSize.callout, color: theme.color.textOnSubviewColor)
                                    .frame(height: 48)
                                    .frame(maxWidth: .infinity)
                                
                            })
                            .buttonStyle(.primaryHButtonStyle(size: .large))
                        }
                    }
                }
                .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 40)
            .frame(maxWidth: .infinity)
            .background(
                theme.color.secondaryBg
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: theme.color.primaryShadow, radius: 10, x: 0, y: 4)
            )
            .padding(.horizontal, 16)
            .opacity(isShow ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .setDefaultBackground()
        .animation(.linear(duration: 0.3), value: isShow)
        .onAppear {
            isShow = true
        }
    }
}

#Preview {
    @Previewable @Environment(\.theme) var theme
    UserInformView(message: UserMessageItem(icon: theme.assets.userAvatar,
                                            title: "Title",
                                            message: "Message"),
                   primaryAction: InformAction(title: "login".localized(),
                                               callback: {}))
    .environmentTheme(manager: ThemeManager.shared)
    
    
    UserInformView(message: UserMessageItem(message: "welcome_message".localized()),
                   primaryAction: InformAction(title: "login".localized(),
                                               callback: {}))
    .environmentTheme(manager: ThemeManager.shared)
}
