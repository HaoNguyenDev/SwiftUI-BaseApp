//
//  LoginButtonView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//

import SwiftUI

struct LoginButtonView: View {
    var size: HButtonStyle.ButtonSize = .medium
    var onTap: VoidResult?
    
    var body: some View {
        VStack {
            Button("login".localized()) {
                onTap?()
            }
            .buttonStyle(.primaryHButtonStyle(size: size))
            .padding(PaddingSize.standard)
        }
        .fillMax()
    }
}
