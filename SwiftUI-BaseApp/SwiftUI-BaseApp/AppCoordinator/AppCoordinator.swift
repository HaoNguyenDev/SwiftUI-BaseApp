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
    @EnvironmentObject var settings: UserSettings
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
            settings.setColorScheme(settings.colorSchemeOption, systemColorScheme: newValue)
        }
        .onAppear {
            settings.setColorScheme(settings.colorSchemeOption, systemColorScheme: systemColorScheme)
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
        Text("device_restricted".localized())
            .font(mainFont.bold(20))
            .foregroundStyle(settings.color.textColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .setBlurBackgroundImage()
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
                        Text("system_maintenance".localized())
                            .font(mainFont.semibold(32))
                            .foregroundStyle(settings.color.textColor)
                        Text("maintenance_message".localized())
                            .font(mainFont.regular())
                            .foregroundStyle(settings.color.textColor)
                    }
                    .multilineTextAlignment(.center)
                }
            }
            .padding(EdgeInsets(top: 130, leading: 40, bottom: 112, trailing: 40))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setBlurBackgroundImage()
    }
}

extension AppCoordinator {
    @ViewBuilder
    private var loadingView: UserInformView {
        let loadingMessage = UserMessageItem(animationName: "ic_boost_loading",
                                             title: "loading".localized(),
                                             message: "loading_message".localized())
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
                let action = InformAction(title: message.actionTitle ?? "close".localized(),
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
        .environmentObject(UserSettings.shared)
        .environmentObject(AppSettings.shared)
        .environmentObject(AppState())
}

