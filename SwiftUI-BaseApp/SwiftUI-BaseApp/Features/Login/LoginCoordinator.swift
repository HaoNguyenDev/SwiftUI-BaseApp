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
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme
    typealias ScreenRouter = Router.Login
    var navRouter: any NavRouterProtocol // No need for Login and Register flow
    @State private var rootRouter = NavRouter() // Create NavRouter for it self
    @State var loginModel: LoginViewModel
    
    init(userSettings: UserSettings) {
        self.navRouter = NavRouter()
        self._loginModel = State(initialValue: LoginViewModel(userSettings: userSettings))
    }
    
    var body: some View {
        NavigationStack(path: $rootRouter.path) {
            loginView
                .navigationDestination(for: ScreenRouter.self) { route in
                    viewForRouter(router: route)
                }
        }
        .ignoresSafeArea(.all)
        
        .sheet(item: $rootRouter.sheet) { sheet in
            showSheet(routable: sheet.routable)
        }
        
        .fullScreenCover(item: $rootRouter.fullScreenCover) { cover in
            showFullScreen(routable: cover.routable)
        }
    }
    
    
    var loginView: some View {
        LoginView(loginModel: loginModel, loginSuccess: { loginResult in
            Logger.shared.debug("\(loginResult)")
            dismiss()
            //            navRouter.push(Router.homeRouter, animate: true)
        }, forgotPassword: {
            rootRouter.push(ScreenRouter.forgotPassword, animate: true)
        }, register: {
            rootRouter.push(ScreenRouter.register, animate: true)
        })
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .forgotPassword:
            //            AccountViewCoordinator(navRouter: navRouter)
            PlaceholderViewCoordinator(navRouter: rootRouter, title: "Forgot Password")
        case .register:
            RegisterCoordinator(navRouter: rootRouter)
        }
    }
}

extension LoginCoordinator {
    @ViewBuilder
    func showSheet(routable: any Routable) -> some View {
        switch routable {
        case Router.PlaceholderView.view(let titleParam):
            PlaceholderViewCoordinator(navRouter: rootRouter, title: titleParam)
        default: Text("OOPS!\nThis route is not implemented LoginCoordinator showSheet function yet.")
        }
    }
    
    @ViewBuilder
    func showFullScreen(routable: any Routable) -> some View {
        switch routable {
        case Router.PlaceholderView.view(let titleParam):
            PlaceholderViewCoordinator(navRouter: rootRouter, title: titleParam)
        default: Text("OOPS!\nThis route is not implemented at LoginCoordinator showFullScreen function yet.")
        }
    }
}

#Preview {
    NavigationStack {
        LoginCoordinator(userSettings: UserSettings())
            .environment(AppState())
    }
}
