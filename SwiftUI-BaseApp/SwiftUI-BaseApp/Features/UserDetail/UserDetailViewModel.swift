//
//  UserDeatilVM.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 1/9/25.
//

import Foundation

class UserDetailViewModel: ObservableObject {
    @Published var userDetail: GithubUserDetail
    
    init(user: GithubUserDetail) {
        self.userDetail = user
    }
}
