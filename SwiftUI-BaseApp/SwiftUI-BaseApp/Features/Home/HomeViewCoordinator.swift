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
    }
    
    @ViewBuilder
    func getView() -> some View {
        HomeView(showLogin: {
            navRouter.showSheet(RouterView.init(routable: Router.AppCoordinator.login))
        }, onShowProfile: {
            navRouter.push(Router.MainTab.profile, animate: true)
        }, gotoSubview1: { info in
            navRouter.push(Router.MainTab.subview1(info: info), animate: true)
        }, gotoSubview2: { info in
            navRouter.push(Router.MainTab.subview2(info: info), animate: true)
        }, showSheet: {
            navRouter.showSheet(RouterView.init(routable: Router.PlaceholderView.view(title: "Test title of sheet parameter")))
        }, showFullScreen: {
            navRouter.showFullScreenCover(RouterView.init(routable: Router.PlaceholderView.view(title: "Test title of fullScreen parameter")))
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
}

