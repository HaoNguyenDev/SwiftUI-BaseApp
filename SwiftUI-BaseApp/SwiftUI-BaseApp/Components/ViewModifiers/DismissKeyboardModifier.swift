//
//  DismissKeyboardModifier.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//


import SwiftUI
import UIKit

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.modifier(DismissKeyboardModifier())
    }
}

struct DismissKeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}


