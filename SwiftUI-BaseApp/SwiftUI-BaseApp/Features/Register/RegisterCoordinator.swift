//
//  RegisterCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 26/10/25.
//

import SwiftUI

extension Router {
    enum Register: Routable {
        case none
        
        var id: String {
            "none"
        }
    }
}


struct RegisterCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.Register
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        registerView()
            .navigationDestination(for: ScreenRouter.self) { router in
                viewForRouter(router: router)
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
    private func registerView() -> some View {
        RegisterView()
    }
    
    @ViewBuilder
    func viewForRouter(router: Router.Register) -> some View {
        switch router {
        case .none:
            EmptyView()
        }
    }
}

struct RegisterView: View {
    var body: some View {
        Text("RegisterView")
    }
}
