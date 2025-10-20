//
//  SampleLoadingView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 20/10/25.
//

import SwiftUI

struct SampleLoadingView: View {
    var title: String?
    
    init(title: String? = nil) {
        self.title = title
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).ignoresSafeArea()
            ProgressView(title ?? "loading".localized())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}
