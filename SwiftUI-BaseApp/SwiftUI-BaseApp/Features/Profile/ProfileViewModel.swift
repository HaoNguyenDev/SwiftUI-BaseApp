//
//  ProfileViewModel.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 25/10/25.
//

import SwiftUI

protocol ProfileViewModelProtocol: ViewStateable {
    func doLogout()
}

@Observable class ProfileViewModel: ProfileViewModelProtocol {
    
    var username: String?
    
    enum ViewState {
        case mainContent
        case logoutView
    }
    private(set) var viewState: ViewState
    
    private var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
        viewState = .mainContent
        username = userSettings.username
    }
    
    func changeState(_ newState: ViewState) {
        viewState = newState
    }
    
    func doLogout() {
        userSettings.logout()
    }
}
