//
//  SplashCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import Foundation
import SwiftUI

extension Router {
    enum Splash {
        case login
        case home
    }
}

struct SplashCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.Splash
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRouter.self) { route in
                viewForRouter(router: route)
            }
    }
    
    @ViewBuilder
    func getView() -> some View {
        SplashView(onSkipUpdate: {
            if UserSettings.shared.hasLogin {
                navRouter.push(ScreenRouter.home, animate: true)
            } else {
                navRouter.push(ScreenRouter.login, animate: true)
            }
        })
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .login:
            LoginCoordinator(navRouter: navRouter)
        case .home:
            PlaceholderViewCoordinator(navRouter: navRouter)
//            MainTabControllerView(navRouter: navRouter)
        }
    }
}
