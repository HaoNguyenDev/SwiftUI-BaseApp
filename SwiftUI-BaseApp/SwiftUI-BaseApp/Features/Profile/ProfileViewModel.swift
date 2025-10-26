//
//  ProfileViewModel.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 25/10/25.
//

import SwiftUI

@Observable class ProfileViewModel {
    var viewState: ViewState
    var username: String?
    private var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
        viewState = .mainContent
        username = userSettings.username
    }

    func doLogout() {
        userSettings.logout()
    }
}

//MARK: - ViewStateable
extension ProfileViewModel: ViewStateable {
    enum ViewState {
        case mainContent
        case logoutView
    }
    
    func changeState(_ newState: ViewState) {
        viewState = newState
    }
}
