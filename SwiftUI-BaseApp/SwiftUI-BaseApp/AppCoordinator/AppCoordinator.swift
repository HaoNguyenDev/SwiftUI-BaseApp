//
//  AppCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

struct AppCoordinator: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var theme: ThemeManager
    @Environment(\.colorScheme) var systemColorScheme
    
    @StateObject var rootRouter = NavRouter()
    @State private var isShowBlockingView: Bool = false
    
    var body: some View {
        Group {
            if isShowBlockingView {
                blockingView
            } else {
                contentView
            }
        }
        .onChange(of: systemColorScheme) { _, newValue in
            theme.updateTheme(theme.colorSchemeOption, systemColorScheme: newValue)
        }
        .onAppear {
            theme.updateTheme(theme.colorSchemeOption, systemColorScheme: systemColorScheme)
        }
        .task { startCheckingApp() }
    }
    
    private func startCheckingApp() {
        let isMatchBundleId = Bundle.main.bundleIdentifier == "haonguyen.SwiftUI-BaseApp"
        
        if !isMatchBundleId {
            isShowBlockingView = true
            return
        }
        
        isShowBlockingView = false
    }
    
    @ViewBuilder
    var blockingView: some View {
        Text("Your device is restricted and not secure!")
            .font(mainFont.bold(20))
            .foregroundStyle(theme.color.textColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .setDefaultBackground()
    }
    
    @ViewBuilder
    var contentView: some View {
        ZStack {
            if appSettings.isMaintenance {
                maintenanceView
            } else {
                NavigationStack(path: $rootRouter.path) {
                    SplashCoordinator(navRouter: rootRouter)
                }
                .ignoresSafeArea(.all)
            }
            if appState.isShowLoading {
                // Loading View
                loadingView
            }
            toastView(appState.userMessageState.toastMessages.first)
            informView(appState.userMessageState.informMessage)
            alertView(appState.userMessageState.alert)
        }
        .onAppear {
        // TODO: Load remote config from backend
        }
    }
    
    @ViewBuilder
    var maintenanceView: some View {
        VStack {
            VStack {
                VStack(spacing: 32) {
                    VStack(spacing: 12) {
                        Text("The system is under maintenance")
                            .font(mainFont.semibold(32))
                            .foregroundStyle(theme.color.textColor)
                        Text("We are working hard to bring you the best experience. Please check back later.")
                            .font(mainFont.regular())
                            .foregroundStyle(theme.color.textColor)
                    }
                    .multilineTextAlignment(.center)
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

extension AppCoordinator {
    @ViewBuilder
    private var loadingView: UserInformView {
        let loadingMessage = UserMessageItem(animationName: "ic_boost_loading",
                                             title: "Loading...",
                                             message: "It may take a while. Thank you for your patient. You are amazing.")
        UserInformView(message: loadingMessage)
    }
    
    @ViewBuilder
    private func toastView(_ message: UserMessageItem?) -> some View {
        Group {
            if let message = message {
                UserMessageView(message: message) { msg in
                    appState.userMessageState.hide()
                    if msg.code == .sectionExpired {
                        rootRouter.pop(to:Router.Splash.login)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func informView(_ message: UserMessageItem?) -> some View {
        Group {
            if let message {
                UserInformView(message: message)
            }
        }
    }
    
    @ViewBuilder
    private func alertView(_ message: UserMessageItem?) -> some View {
        Group {
            if let message  {
                let action = InformAction(title: message.actionTitle ?? "Close",
                                          callback: {
                    appState.userMessageState.hideAlert()
                    if message.code == .sectionExpired {
                        rootRouter.popToRoot()
                        rootRouter.push(Router.Splash.login, animate: false)
                    }
                })
                
                UserInformView(message: message,
                               primaryAction: action)
            }
        }
    }
}

#Preview {
    AppCoordinator()
}

