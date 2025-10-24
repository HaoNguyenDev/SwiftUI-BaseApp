//
//  CustomNavigationTitleColor.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//

import SwiftUI
import UIKit

extension View {
    func customNavigationTitleColor(_ color: Color) -> some View {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let navigationController = window.rootViewController as? UINavigationController else {
            return self
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.titleTextAttributes = [.foregroundColor: color]
        appearance.largeTitleTextAttributes = [.foregroundColor: color]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationController?.navigationBar.compactAppearance = appearance

        return self
    }
}
