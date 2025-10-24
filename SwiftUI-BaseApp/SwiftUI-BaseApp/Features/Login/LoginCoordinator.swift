//
//  LoginCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

extension Router {
    enum Login: Routable {
        case forgotPassword
        case register
        
        var id: String {
            switch self {
            case .forgotPassword:
                return "forgotPassword"
            case .register:
                return "register"
            }
        }
    }
}

struct LoginCoordinator: View, ScreenCoordinator {
    @Environment(\.theme) var theme
    typealias ScreenRouter = Router.Login
    var navRouter: any NavRouterProtocol
    
    @State var loginModel: LoginModel
    
    init(navRouter: any NavRouterProtocol, userSettings: UserSettings) {
        self.navRouter = navRouter
        self._loginModel = State(initialValue: LoginModel(userSettings: userSettings))
    }
    
    var body: some View {
        loginView
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    CloseButton(action: {
                        navRouter.dismiss()
                    })
                }
            })
            .navigationBarBackButtonHidden(true)
//            .navigationTitle("login_title".localized())
//            .customNavigationTitleColor(theme.color.primaryText)
    }
    
    
    var loginView: some View {
        LoginView(loginModel: loginModel, loginSuccess: { loginResult in
            Logger.shared.debug("\(loginResult)")
            navRouter.push(Router.homeRouter, animate: true)
        }, forgotPassword: {
            navRouter.push(ScreenRouter.forgotPassword, animate: true)
        }, register: {
            navRouter.push(ScreenRouter.register, animate: true)
        })
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .forgotPassword:
            //            AccountViewCoordinator(navRouter: navRouter)
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Forgot Password")
        case .register:
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Register")
        }
    }
}

#Preview {
    NavigationView {
        LoginCoordinator(navRouter: NavRouter(), userSettings: UserSettings())
            .environment(AppState())
    }
}
