//
//  ScreenCoordinator.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

protocol ScreenCoordinator {
    associatedtype ScreenRoute
    associatedtype Screen: View

    var navRouter: NavRouterProtocol { get set }
    
    @ViewBuilder
    func viewForRoute(route: ScreenRoute) -> Screen
}
