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

class LoginModel: ObservableObject {
    
    func doLogin() async throws -> LoginResult {
        try? await Task.sleep(for: .seconds(2))
//        let randomNumber = Int.random(in: 1...2)
        let username: String = ["haonguyen", "minhhoang", "tuananh", "tuananh123", "tuananh456"].randomElement() ?? "Unknown"
//        if randomNumber == 1 {
            let loginResult: LoginResult = .init(token: "token 1234",
                                                 refreshToken: "refresh token 1234",
                                                 username: username,
                                                 referralCode: "1234")
            
            Task { @MainActor in
                UserSettings.shared.username = loginResult.username
                UserSettings.shared.token = loginResult.token
            }
            
            return loginResult
//        } else {
//            throw LoginError.failed
//        }
    }
}
