//
//  SettingsCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI
extension Router {
    enum SettingsView: Routable {
        case view
        var id: String {
            switch self {
            case .view:
                return "view"
            }
        }
    }
}

struct SettingsCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.SettingsView

    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }

    var body: some View {
        settingsView()
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
    private func settingsView() -> some View {
        SettingsView(gotoChangeLanguageView: {
            navRouter.push(ScreenRouter.view, animate: true)
        })
    }

    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .view:
            PlaceholderViewCoordinator(navRouter: navRouter)
        }
    }
}
