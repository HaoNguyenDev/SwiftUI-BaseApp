//
//  RegisterViewModel.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 28/10/25.
//

import SwiftUI
import Combine

@Observable class RegisterViewModel: ViewStateable {
   
    var viewState: ViewState = .contentView /// ViewStateable
    private var cancellables = Set<AnyCancellable>()
    
    var email: String = "" {
        didSet {
            handleIputEmailChanged(to: email)
        }
    }
    
    var password: String = "" {
        didSet {
            handleInputPasswordChanged(to: password)
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
    
    init() {
        viewState = .contentView
    }
    
}

// MARK: ViewStateable
extension RegisterViewModel {
    enum ViewState {
        case contentView
        case loading
        case failed(Error)
        case success
    }
    
    func changeState(_ newState: ViewState) {
        viewState = newState
    }
}

// MARK: - Validation
extension RegisterViewModel {
    
    private func handleIputEmailChanged(to email: String) {
        Task {
            try await Task.sleep(for: .milliseconds(100))
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
    
    private func handleInputPasswordChanged(to password: String) {
        Task {
            try await Task.sleep(for: .milliseconds(100))
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
}

