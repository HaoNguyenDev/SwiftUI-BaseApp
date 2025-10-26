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
    @Environment(UserSettings.self) var userSettings
    @Environment(\.theme) var theme: any ThemeProtocol
    var finishSplash: VoidResult?
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
        VStack {
            Text("splas_screen_title".localized())
                .boldStyle(theme, size: TextSize.largeTitle, color: theme.color.primaryText, alignment: .center)
            
            Button("Finish Splash".localized()) {
                userSettings.hasFinishSplash = true
                finishSplash?()
            }
            .primaryHButton()
            .padding(.horizontal, PaddingSize.standard)
        }
        .onAppear {
            if userSettings.hasFinishSplash {
                finishSplash?()
            }
        }
    }
    
    @ViewBuilder
    var updateView: some View {
        VStack {
            VStack {
                VStack(spacing: 32) {
                   
                    VStack(spacing: 12) {
                        Text("please_update".localized())
                            .regularStyle(theme, size: TextSize.title1, color: theme.color.primaryText)
                        Text("update_the_app_now".localized())
                            .regularStyle(theme, size: TextSize.subhead, color: theme.color.secondaryText)
                    }
                }
                Spacer()
                VStack(spacing: 16) {
                    Button("update".localized()) {
                        updateAppProcess()
                    }
                    .buttonStyle(.primaryHButton)
                    
                    Button("skip".localized()) {
                        finishSplash?()
                    }
                    .buttonStyle(.secondaryHButton)
                    
                }
            }
            .padding(EdgeInsets(top: 130, leading: 40, bottom: 112, trailing: 40))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setPrimaryBackground()
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
                finishSplash?()
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
                                             title: "loading".localized(),
                                             message: "loading_message".localized())
        UserInformView(message: loadingMessage)
    }
}

#Preview {
    SplashView()
        .environment(AppState())
        .environment(AppSettings())
        .environment(UserSettings())
        .environmentTheme(manager: ThemeManager.shared)
}
