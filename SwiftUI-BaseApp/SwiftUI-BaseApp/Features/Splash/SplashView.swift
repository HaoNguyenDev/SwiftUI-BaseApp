//
//  SplashView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

struct SplashView: View {
    @Environment(AppState.self) var appState
    @Environment(AppSettings.self) var appSettings
    @Environment(\.theme) var theme: any ThemeProtocol
    var onSkipUpdate: VoidResult?
    @State var showLoading: Bool = false
    
    var body: some View {
        if appSettings.isNeedUpdate {
            if showLoading {
                loadingView
            } else {
                updateView
            }
        } else {
            contentView
        }
        
    }
}

extension SplashView {
    @ViewBuilder
    var contentView: some View {
        VStack {}
            .onAppear {
                onSkipUpdate?()
            }
    }
    
    @ViewBuilder
    var updateView: some View {
        VStack {
            VStack {
                VStack(spacing: 32) {
                   
                    VStack(spacing: 12) {
                        Text("splas_screen_title".localized())
                            .regularStyle(theme, size: 50, color: theme.color.textColor)
                        Text("please_update".localized())
                            .boldStyle(theme, size: 32, color: theme.color.textColor)
                        Text("update_the_app_now".localized())
                            .regularStyle(theme, size: AppTextStyleSize.footnote, color: theme.color.textColor)
                    }
                    .multilineTextAlignment(.center)
                }
                Spacer()
                VStack(spacing: 16) {
                    Button(action: {
                        Logger.shared.debug("Update App")
                        updateAppProcess()
                    }, label: {
                        Text("update".localized())
                            .regularStyle(theme, size: AppTextStyleSize.body, color: theme.color.textColor)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button(action: {
                        onSkipUpdate?()
                    }, label: {
                        Text("skip".localized())
                            .regularStyle(theme, size: AppTextStyleSize.body, color: theme.color.textColor)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(SecondaryButtonStyle())
                }
            }
            .padding(EdgeInsets(top: 130, leading: 40, bottom: 112, trailing: 40))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setDefaultBackground()
    }
}

extension SplashView {
    private func updateAppProcess() {
        Task {
            await appState.showLoading()
            showLoading = true
            do {
                try await Task.sleep(for: .seconds(2))
                showLoading = false
                await appState.hideLoading()
                appState.showToast(item: UserMessageItem(message: "welcome_message_app".localized()))
                onSkipUpdate?()
            } catch {
                // TODO: Handle later
                showLoading = false
                await appState.hideLoading()
                appState.handleError(error: error, action: .toast)
            }
        }
    }
    
    @ViewBuilder
    private var loadingView: UserInformView {
        let loadingMessage = UserMessageItem(animationName: "RoadLoading",
                                             title: "Loading...",
                                             message: "It may take a while. Thank you for your patient. You are amazing.")
        UserInformView(message: loadingMessage)
    }
}

#Preview {
    SplashView()
        .environment(AppState())
        .environment(AppSettings())
        .environmentTheme(manager: ThemeManager.shared)
        .preferredColorScheme(.dark)
}
