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
    typealias ScreenRouter = Router.Login
    var navRouter: any NavRouterProtocol
    
    // Sử dụng @State thay cho @StateObject với @Observable class
    @State var loginModel: LoginModel
    
    init(navRouter: any NavRouterProtocol, userSettings: UserSettings) {
        self.navRouter = navRouter
        // Bây giờ userSettings đã có giá trị, nên không còn lỗi nữa.
        self._loginModel = State(initialValue: LoginModel(userSettings: userSettings))
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
            Logger.shared.debug("\(loginResult)")
            navRouter.push(Router.homeRouter, animate: true)
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
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Forgot Password")
        case .register:
            PlaceholderViewCoordinator(navRouter: navRouter, title: "Register")
        }
    }
}
