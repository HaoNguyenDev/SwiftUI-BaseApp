//
//  Button+Additional.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 25/10/25.
//

import SwiftUI

// MARK: - HButtonStyle
extension Button {
    func primaryHButton(size: HButtonStyle.ButtonSize = .large) -> some View {
        self.buttonStyle(.primaryHButtonStyle(size: size))
    }
    
    func secondaryHButton(size: HButtonStyle.ButtonSize = .large) -> some View {
        self.buttonStyle(.secondaryHButtonStyle(size: size))
    }
    
    func tertiaryHButton(size: HButtonStyle.ButtonSize = .large) -> some View {
        self.buttonStyle(.tertiaryHButtonStyle(size: size))
    }
}
