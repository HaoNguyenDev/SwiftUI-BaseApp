//
//  PlaceholderViewCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

extension Router {
    enum PlaceholderView: Routable {
        case view(title: String)
        
        var id: String {
            switch self {
            case .view(title: let title):
                return title + UUID().uuidString
            }
        }
    }
}

struct PlaceholderViewCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.PlaceholderView
    var navRouter: any NavRouterProtocol
    var title: String?
    
    init(navRouter: any NavRouterProtocol, title: String? = nil) {
        self.navRouter = navRouter
        self.title = title
    }
    
    var body: some View {
        getView()
//            .navigationDestination(for: ScreenRouter.self) { route in
//                viewForRouter(router: route)
//            }
        //        .toolbar(.hidden, for: .bottomBar)
        //        .toolbar(.hidden, for: .tabBar)
        //        .toolbar(.hidden, for: .navigationBar)
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
        PlaceholderView(newTitle: title,
                        onClose: {
            navRouter.pop(animate: true)
        })
        
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .view:
            ContentView()
        }
    }
}
