//
//  UserDetailCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 1/9/25.
//

import SwiftUI

extension Router {
    enum UserDetail: Routable {
        case subview
        
        var id: String {
            switch self {
            case .subview:
                return "UserDetail.subview"
            }
        }
    }
}

struct UserDetailCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.UserDetail
    var navRouter: any NavRouterProtocol
    var user: GithubUserDetail
    @StateObject private var viewModel: UserDetailViewModel
    init(navRouter: any NavRouterProtocol, user: GithubUserDetail) {
        self.navRouter = navRouter
        self.user = user
        self._viewModel = StateObject(wrappedValue: UserDetailViewModel(user: user))
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRouter.self) { route in
                viewForRouter(router: route)
            }
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
    func getView() -> some View {
        UserDetailView(vm: viewModel, gotoSubview: {
            navRouter.push(ScreenRouter.subview, animate: true)
        })
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .subview:
           EmptyView()
        }
    }
}


