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
            R.color.launchScreenBg.color.ignoresSafeArea()
            ProgressView(){
                Text(title ?? "loading".localized())
                    .font(R.font.ttHovesProTrialRg.font(size: 20))
                    .foregroundStyle(R.color.primaryText.color)
            }
            .padding()
            .background(R.color.secondaryBg.color)
            .cornerRadius(10)
        }
    }
}
