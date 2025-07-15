//
//  SampleView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

struct SampleView: View {
    
    var gotoSubview1: (() -> Void)?
    var gotoSubview2: (() -> Void)?
    
    var body: some View {
        contentView()
    }
}

extension SampleView {
    @ViewBuilder
    func contentView() -> some View {
        Text("sample_view".localized())
    }
}

#Preview {
    SampleView(gotoSubview1: nil, gotoSubview2: nil)
}
