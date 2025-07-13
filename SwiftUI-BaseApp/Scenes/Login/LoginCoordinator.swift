//
//  LoginCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

extension Router {
    enum Login {
        case forgotPassword
        case register
    }
}

struct LoginCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.Login
    var navRouter: any NavRouterProtocol
    
    @StateObject var loginModel = LoginModel()
    
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
        LoginView(loginModel: loginModel, loginSuccess: { loginResult in
            print(loginResult)
//            navRouter.push(Router.homeRoute, animate: true)
        }, forgotPassword: {
            navRouter.push(ScreenRouter.forgotPassword, animate: true)
        }, register: {
            navRouter.push(ScreenRouter.register, animate: true)
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .forgotPassword:
//            AccountViewCoordinator(navRouter: navRouter)
            PlaceholderViewCoordinator(navRouter: navRouter)
        case .register:
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Register")
        }
    }
}
