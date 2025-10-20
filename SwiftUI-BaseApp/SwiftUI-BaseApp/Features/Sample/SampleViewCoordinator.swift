//
//  SampleViewCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

extension Router {
    enum SampleView: Routable {
        case subview1
        case subview2
        
        var id: String {
            switch self {
            case .subview1:
                return "SampleView.subview1"
            case .subview2:
                return "SampleView.subview2"
            }
        }
    }
}

struct SampleViewCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.SampleView
    var navRouter: any NavRouterProtocol
    
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
        SampleView(gotoSubview1: {
            navRouter.push(ScreenRouter.subview1, animate: true)
        }, gotoSubview2: {
            navRouter.push(ScreenRouter.subview2, animate: true)
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .subview1:
            PlaceholderViewCoordinator(navRouter: navRouter)
        case .subview2:
            PlaceholderViewCoordinator(navRouter: navRouter)
        }
    }
}

