//
//  UserDetailView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 1/9/25.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewModel
    var gotoSubview: (() -> Void)?
    
    var body: some View {
        contentView()
    }
}

extension UserDetailView {
    @ViewBuilder
    func contentView() -> some View {
        VStack {
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setDefaultBackground()
    }
}

#Preview {
    UserDetailView(viewModel: UserDetailViewModel(user: GithubUserDetail()), gotoSubview: nil)
        .environment(UserSettings())
}
