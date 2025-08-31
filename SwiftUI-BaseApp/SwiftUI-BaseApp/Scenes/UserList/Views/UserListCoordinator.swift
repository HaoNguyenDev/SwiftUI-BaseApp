//
//  UserListCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//

import SwiftUI

extension Router {
    enum UserListView: Routable {
        case userDetail
        
        var id: String {
            switch self {
            case .userDetail:
                return "UserListView.UserDetail"
            }
        }
    }
}

struct UserListCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.UserListView
    var navRouter: any NavRouterProtocol
    @StateObject private var viewModel = GithubUserListVM()
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
        UserListView(viewModel: viewModel, gotoUserDetail: { id in
            navRouter.push(ScreenRouter.userDetail, animate: true)
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .userDetail:
            PlaceholderViewCoordinator(navRouter: navRouter, title: "UserDetail")
        }
    }
}


