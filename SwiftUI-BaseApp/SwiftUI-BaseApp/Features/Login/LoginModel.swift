//
//  LoginModel.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import Foundation

struct LoginResult {
    let token: String
    let refreshToken: String?
    let username: String
    let referralCode: String?
}

enum LoginError: Error {
    case failed
    
    var errorMessage: String {
        switch self {
        case .failed:
            return "Login Failed! Please try again later."
        }
    }
}

protocol LoginViewModelProtocol: ViewStateable {
    
}

@Observable class LoginModel: LoginViewModelProtocol {
   
    enum ViewState {
        case content
        case loading
        case success(LoginResult)
        case failure(Error)
    }
    
    private(set) var viewState: ViewState = .content

    private var userSettings: UserSettings
    init (userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    func changeState(_ newState: ViewState) {
        viewState = newState
    }
    
    func doLogin() {
        viewState = .loading
        Task {
            try? await Task.sleep(for: .seconds(2))
            let username: String = ["haonguyen", "minhhoang", "tuananh", "tuananh123", "tuananh456"].randomElement() ?? "Unknown"
//            if Int.random(in: 1...2) == 1 {
                let loginResult: LoginResult = .init(token: "token 1234",
                                                     refreshToken: "refresh token 1234",
                                                     username: username,
                                                     referralCode: "1234")
                
                Task { @MainActor in
                    userSettings.username = loginResult.username
                    userSettings.token = loginResult.token
                }
                
                viewState = .success(loginResult)
//            } else {
//                viewState = .failure(LoginError.failed)
//            }
        }
    }
}
