//
//  AccountViewCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

extension Router {
    enum AccountView {
        case none
    }
}

struct AccountViewCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.AccountView
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        accountView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
    }
    
    @ViewBuilder
    func accountView() -> some View {
        AccountView(gotoSettings: {
            navRouter.push(Router.MainTab.settings, animate: true)
        }, gotoProfile: {
            navRouter.push(Router.MainTab.profile, animate: true)
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .none:
            PlaceholderViewCoordinator(navRouter: navRouter)
        }
    }
}

