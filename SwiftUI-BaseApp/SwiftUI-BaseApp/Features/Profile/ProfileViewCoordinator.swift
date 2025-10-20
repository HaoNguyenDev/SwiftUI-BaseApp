//
//  ProfileViewCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

extension Router {
    enum ProfileView: Routable {
        case login
        case settings
        case logoutConfirm
        
        var id: String {
            switch self {
            case .login:
                return "login"
            case .settings:
                return "settings"
            case .logoutConfirm:
                return "logoutConfirm"
            }
        }
    }
}

struct ProfileViewCoordinator: View, ScreenCoordinator {
    @Environment(UserSettings.self) private var userSettings
    typealias ScreenRouter = Router.ProfileView
    
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        profileView()
        .navigationDestination(for: ScreenRouter.self) { router in
            viewForRouter(router: router)
        }
        .toolbar(.hidden, for: .bottomBar)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            navRouter.pop(animate: true)
        }) {
            BackButton()
        })
    }
    
    @ViewBuilder
    private func profileView() -> some View {
        ProfileView(
            showSettingsView: {
                navRouter.push(ScreenRouter.settings, animate: true)
            },
            showLogoutConfirmView: {
                navRouter.push(ScreenRouter.logoutConfirm, animate: false)
            }
        )
    }
    
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .settings:
            SettingsCoordinator(navRouter: navRouter)
        case .login:
            LoginCoordinator(navRouter: navRouter, userSettings: userSettings)
        case .logoutConfirm:
            LogoutConfirmView {
                navRouter.pop(animate: false)
            } onLogout: {
                doLogout()
            }
            
        }
    }
}

extension ProfileViewCoordinator {
    private func doLogout() {
        userSettings.logout()
        navRouter.pop(to: Router.Splash.login, animate: false)
    }
}
