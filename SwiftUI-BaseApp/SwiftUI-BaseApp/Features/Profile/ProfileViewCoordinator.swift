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
        
        var id: String {
            switch self {
            case .settings:
                return "settings"
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
            .toolbar {
                // (Leading)
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: {
                        navRouter.pop(animate: true)
                    })
                }
            }
    }
    
    @ViewBuilder
    private func profileView() -> some View {
        ProfileView(
            viewModel: ProfileViewModel(userSettings: userSettings),
            showSettingsView: {
                navRouter.push(ScreenRouter.settings, animate: true)
            }, popToRoot: {
                navRouter.pop(animate: false)
            })
    }
    
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .settings:
            SettingsCoordinator(navRouter: navRouter)
        }
    }
}
