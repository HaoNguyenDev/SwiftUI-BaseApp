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
            R.color.backgroundView.color.ignoresSafeArea()
            ProgressView(){
                Text(title ?? "loading".localized())
                    .font(R.font.ttHovesProTrialRg.font(size: 20))
                    .foregroundStyle(R.color.textPrimary.color)
            }
            .padding()
            .background(R.color.backgroundView.color)
            .cornerRadius(10)
        }
    }
}
