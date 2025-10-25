//
//  ProfileViewCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

extension Router {
    enum ProfileView: Routable {
        case settings
        case logoutView
        
        var id: String {
            switch self {
            case .settings:
                return "settings"
            case .logoutView:
                return "logoutView"
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
            userSettings: userSettings, showSettingsView: {
                navRouter.push(ScreenRouter.settings, animate: true)
            }, showLogoutView: {
                navRouter.push(ScreenRouter.logoutView, animate: false)
            })
    }
    
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .settings:
            SettingsCoordinator(navRouter: navRouter)
        case .logoutView:
            LogoutConfirmView {
                doLogout()
            } onDismiss: {
                navRouter.pop(animate: false)
            }

        }
    }
}

extension ProfileViewCoordinator {
    private func doLogout() {
        userSettings.logout()
        navRouter.popToRoot()
    }
}
