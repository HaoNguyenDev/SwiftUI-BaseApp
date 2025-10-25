//
//  ClearBackgroundViewModifier.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 25/10/25.
//


import SwiftUI
import UIKit

extension View {
    func clearBackground() -> some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard let window = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first else { return }

                if let viewController = window.rootViewController {
                    findAndClearBackground(in: viewController)
                }
            }
    }
    
    private func findAndClearBackground(in controller: UIViewController) {
        if let presentationController = controller.presentationController {
            presentationController.containerView?.backgroundColor = .clear
            presentationController.presentedView?.backgroundColor = .clear
        }

        if let hostingController = controller as? UIHostingController<AnyView> {
             hostingController.view.backgroundColor = .clear
        }
        
        controller.children.forEach { findAndClearBackground(in: $0) }
    }
}
