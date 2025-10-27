//
//  LoginModel.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import Foundation
import Combine

struct LoginResult {
    let token: String
    let refreshToken: String?
    let username: String
    let referralCode: String?
}

@Observable class LoginViewModel {
    private var userSettings: UserSettings
    var viewState: ViewState = .contentView /// ViewStateable
    private var cancellables = Set<AnyCancellable>()
    
    var email: String = "" {
        didSet {
            Task {
                try await Task.sleep(for: .milliseconds(300))
                guard !Task.isCancelled else { return }
                
                let error = validEmail(with: email)
                isEmailValid = error == nil
                if let emailError = error as EmailFieldError? {
                    emailErrorMessage = emailError.errorDescription
                } else {
                    emailErrorMessage = nil
                }
            }
        }
    }
    
    var password: String = "" {
        didSet {
            Task {
                try await Task.sleep(for: .milliseconds(300))
                guard !Task.isCancelled else { return }
                
                let error = validPassword(with: password)
                isPasswordValid = error == nil
                if let passwordError = error as PasswordFieldError? {
                    passwordErrorMessage = passwordError.errorDescription
                } else {
                    passwordErrorMessage = nil
                }
            }
        }
    }
    
    var isRememberMe: Bool = false
    
    // Output States
    var loginErrorMessage: String?
    
    var isEmailValid = false
    var emailErrorMessage: String? = nil
    
    var isPasswordValid = false
    var passwordErrorMessage: String? = nil
    
    var isLoginButtonEnabled: Bool {
        return isEmailValid && isPasswordValid
    }
    
    init (userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    func doLogin() async {
        viewState = .loading
        try? await Task.sleep(for: .seconds(2))
        let username: String = ["haonguyen", "minhhoang", "tuananh", "tuananh123", "tuananh456"].randomElement() ?? "Unknown"
        
        let loginResult: LoginResult = .init(token: "token 1234",
                                             refreshToken: "refresh token 1234",
                                             username: username,
                                             referralCode: "1234")
        Task { @MainActor in
            userSettings.username = loginResult.username
            userSettings.token = loginResult.token
        }
        viewState = .success(loginResult)
    }
}

extension LoginViewModel: ViewStateable {
    enum ViewState {
        case contentView
        case loading
        case success(LoginResult)
        case failure(Error)
    }
    
    func changeState(_ newState: ViewState) {
        viewState = newState
    }
}

// MARK: - Validation
extension LoginViewModel {
    
    private func validEmail(with email: String) -> EmailFieldError? {
        if email.isEmpty { return EmailFieldError.empty }
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        guard email.range(of: regex, options: .regularExpression) != nil else {
            return EmailFieldError.incorrectFormat
        }
        return nil
    }
    
    private func validPassword(with password: String) -> PasswordFieldError? {
        if password.isEmpty { return PasswordFieldError.empty }
        if password.count < 6 { return PasswordFieldError.wrongLength }
        let regex = "^(?=.*[a-zA-Z])(?=.*\\d).{6,}$"
        guard password.range(of: regex, options: .regularExpression) != nil else {
            return PasswordFieldError.incorrect
        }
        return nil
    }
    
    private func setupValidation<T: Error>(
        for publisher: Published<String>.Publisher,
        validation: @escaping (String) -> Error?,
        isValid: ReferenceWritableKeyPath<LoginViewModel, Bool>,
        errorMessage: ReferenceWritableKeyPath<LoginViewModel, String?>,
        errorType: T.Type
    ) {
        publisher
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] input in
                guard let self = self else { return }
                let error = validation(input)
                self[keyPath: isValid] = (error == nil)
                if let specificError = error as? T {
                    self[keyPath: errorMessage] = specificError.localizedDescription
                } else {
                    self[keyPath: errorMessage] = nil
                }
            }
            .store(in: &cancellables)
    }
}
