//
//  HomeViewCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

extension Router {
    enum Home: Routable {
        case subview
        
        var id: String {
            switch self {
            case .subview:
                return "Home.subview"
            }
        }
    }
}

struct HomeViewCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.Home
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
    }
    
    @ViewBuilder
    func getView() -> some View {
        HomeView(onShowProfile: {
            navRouter.push(Router.MainTab.profile, animate: true)
        }, gotoSubview1: {
            navRouter.push(Router.MainTab.subview1, animate: true)
        }, gotoSubview2: {
            navRouter.push(Router.MainTab.subview2, animate: true)
        }, showSheet: {
            navRouter.showSheet(RouterView.init(routable: Router.PlaceholderView.view))
        }, showFullScreen: {
            navRouter.showFullScreenCover((RouterView.init(routable: Router.PlaceholderView.view)))
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .subview:
            EmptyView()
        }
    }
}

