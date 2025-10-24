//
//  LoginButtonView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//

import SwiftUI

struct LoginButtonView: View {
    var onTap: VoidResult?
    
    var body: some View {
        VStack {
            Button("login".localized()) {
                onTap?()
            }
            .buttonStyle(.primaryHButton)
            .padding(PaddingSize.standard)
        }
        .fillMax()
    }
}
