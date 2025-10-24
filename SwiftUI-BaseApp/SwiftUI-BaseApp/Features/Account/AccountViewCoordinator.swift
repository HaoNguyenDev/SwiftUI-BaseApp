//
//  AccountViewCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

extension Router {
    enum AccountView: Routable {
        case none
        
        var id: String {
            switch self {
            case .none:
                return "none"
            }
        }
    }
}

struct AccountViewCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.AccountView
    var navRouter: any NavRouterProtocol
    private var viewModel: AccountViewModelProtocol
    
    init(viewModel: AccountViewModelProtocol, navRouter: any NavRouterProtocol) {
        self.viewModel = viewModel
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
        AccountView(vm: viewModel, gotoSettings: {
            navRouter.push(Router.MainTab.settings, animate: true)
        }, gotoProfile: {
            navRouter.push(Router.MainTab.profile, animate: true)
        }, showLogin: {
            navRouter.showSheet(RouterView.init(routable: Router.MainTab.login))
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

