//
//  AppCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

extension Router {
    enum AppCoordinator: Routable {
        case login
        case home
        var id: String {
            switch self {
            case .login: return "AppCoordinator.login"
            case .home: return "AppCoordinator.home"
            }
        }
    }
}

struct AppCoordinator: View {
    @Environment(AppSettings.self) var appSettings
    @Environment(AppState.self) var appState
    @Environment(UserSettings.self) var userSettings
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(\.colorScheme) var systemColorScheme
    
    @State var rootRouter = NavRouter()
    @State private var isShowBlockingView: Bool = false
    @State private var hasFinishSplash: Bool = false
    
    var body: some View {
        Group {
            if isShowBlockingView {
                blockingView
            } else {
                contentView
            }
        }
        .onAppear {
            userSettings.setColorScheme(userSettings.colorSchemeOption, systemColorScheme: systemColorScheme)
        }
        .onChange(of: systemColorScheme) { _, newValue in
            userSettings.setColorScheme(userSettings.colorSchemeOption, systemColorScheme: newValue)
        }
        .task {
            validateApp()
        }
    }
    
    private func validateApp() {
        let isMatchBundleId = Bundle.main.bundleIdentifier == "haonguyen.SwiftUI-BaseApp"
        isShowBlockingView = !isMatchBundleId
    }
    
    @ViewBuilder
    var blockingView: some View {
        Text("device_restricted".localized())
            .boldStyle(theme, size: 20, color: theme.color.textColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .setPrimaryBackground()
    }
    
    @ViewBuilder
    var contentView: some View {
        ZStack {
            if appSettings.isMaintenance {
                maintenanceView
            } else {
                NavigationStack(path: $rootRouter.path) {
                    if appState.appPhase == .splashView {
                        SplashCoordinator(navRouter: rootRouter)
                    } else {
                        MainTabControllerView(navRouter: rootRouter)
                    }
                }
                .ignoresSafeArea(.all)
                
                .sheet(item: $rootRouter.sheet) { sheet in
                    showSheet(routable: sheet.routable)
                }
                .fullScreenCover(item: $rootRouter.fullScreenCover) { cover in
                    showFullScreen(routable: cover.routable)
                }
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
                            .semiboldStyle(theme, size: 32, color: theme.color.textColor)
                        Text("maintenance_message".localized())
                            .regularStyle(theme, size: 17, color: theme.color.textColor)
                    }
                    .multilineTextAlignment(.center)
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

extension AppCoordinator {
    @ViewBuilder
    func showSheet(routable: any Routable) -> some View {
        switch routable {
        case Router.AppCoordinator.login:
            LoginCoordinator(mainTabNavRouter: rootRouter, userSettings: userSettings)
        case Router.PlaceholderView.view(let titleParam):
            PlaceholderViewCoordinator(navRouter: rootRouter, title: titleParam)
        default: Text("OOPS!\nThis route is not implemented AppCoordinator showSheet function yet.")
        }
    }
    
    @ViewBuilder
    func showFullScreen(routable: any Routable) -> some View {
        switch routable {
        case Router.AppCoordinator.login:
            LoginCoordinator(mainTabNavRouter: rootRouter, userSettings: userSettings)
        case Router.PlaceholderView.view(let titleParam):
            PlaceholderViewCoordinator(navRouter: rootRouter, title: titleParam)
        default: Text("OOPS!\nThis route is not implemented at AppCoordinator showFullScreen function yet.")
        }
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
                        rootRouter.pop(to:Router.Splash.maintab)
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
                        rootRouter.push(Router.Splash.maintab, animate: false)
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
        .environment(UserSettings())
        .environment(AppSettings())
        .environment(AppState())
}

