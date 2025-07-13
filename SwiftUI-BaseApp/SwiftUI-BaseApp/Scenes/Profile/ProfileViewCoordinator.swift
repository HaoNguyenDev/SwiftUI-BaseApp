//
//  ProfileViewCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

extension Router {
    enum ProfileView: Hashable {
        case login
        case settings
        case logoutConfirm
    }
}

struct ProfileViewCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.ProfileView
    
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        ProfileView(
            showSettingsView: {
                navRouter.push(ScreenRouter.settings, animate: true)
            },
            showLogoutConfirmView: {
                navRouter.push(ScreenRouter.logoutConfirm, animate: false)
            }
        )
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
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .settings:
            SettingsCoordinator(navRouter: navRouter)
        case .login:
            LoginCoordinator(navRouter: navRouter)
        case .logoutConfirm:
            LogoutConfirmView {
                navRouter.pop(to: Router.homeRouter)
            } onLogout: {
                doLogout()
            }
            
        }
    }
}

extension ProfileViewCoordinator {
    private func doLogout() {
        UserSettings.shared.logout()
        navRouter.pop(to: Router.Splash.login)
    }
}
