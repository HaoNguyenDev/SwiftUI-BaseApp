//
//  SplashView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var theme: ThemeManager
    var onSkipUpdate: VoidResult?
    @State var showLoading: Bool = false
    var body: some View {
        if AppSettings.shared.isNeedUpdate {
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
                            .set(font: mainFont.bold(50), and: theme.color.textColor)
                        Text("please_update".localized())
                            .set(font: mainFont.bold(32), and: theme.color.textColor)
                        Text("update_the_app_now".localized())
                            .set(font: mainFont.regular(14), and: theme.color.textColor)
                    }
                    .multilineTextAlignment(.center)
                }
                Spacer()
                VStack(spacing: 16) {
                    Button(action: {
                        print(">>> Update App Now <<<")
                        updateAppProcess()
                    }, label: {
                        Text("update".localized())
                            .foregroundStyle(theme.color.textColor)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button(action: {
                        onSkipUpdate?()
                    }, label: {
                        Text("skip".localized())
                            .foregroundStyle(theme.color.textColor)
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
                appState.showToast(item: UserMessageItem(message: "Welcome to App. Enjoy your trip and earn more gifts."))
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
}
