//
//  RegisterView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 27/10/25.
//

import SwiftUI

struct RegisterView: View {
    @Environment(AppState.self) var appState
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: RegisterViewModel
    private let registerSuccess: VoidResult?
    
    init(viewModel: RegisterViewModel,
         registerSuccess: VoidResult?) {
        self.viewModel = viewModel
        self.registerSuccess = registerSuccess
    }
    
    var body: some View {
        ScrollView {
            contentView
        }
        .fillMax()
        .safeAreaInsetsViewModifier(verticalEdge: .bottom)
        .setPrimaryBackground()
        .dismissKeyboardOnTap()
    }
}

// MARK: - UI
extension RegisterView {
    private var contentView: some View {
        VStack {
            VStack(spacing: PaddingSize.standard) {
                loginTitle
                inputFields
                Spacer().frame(height: 20)
                registerButton
                Spacer()
            }
        }
    }
    
    private var loadingView: some View {
        VStack {
            LoadingView()
        }
    }
    
    private var loginTitle: some View {
        Text("register_title".localized())
            .boldStyle(theme, size: TextSize.largeTitle, color: theme.color.primaryText, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(PaddingSize.standard)
    }
    
    private var inputFields: some View {
        VStack(spacing: PaddingSize.standard) {
            HTextField(title: "email".localized(),
                       placeholder: "enter_your_email".localized(),
                       keyboardType: .emailAddress,
                       leftImage: theme.assets.iconEmail,
                       text: $viewModel.email,
                       errorMessage: $viewModel.emailErrorMessage)
            .padding(.horizontal, PaddingSize.standard)
            .padding(.bottom, PaddingSize.tight)
            
            HTextField(title: "password".localized(),
                       placeholder: "enter_your_password".localized(),
                       keyboardType: .default,
                       leftImage: theme.assets.iconPassword,
                       text: $viewModel.password,
                       errorMessage: $viewModel.passwordErrorMessage)
            .padding(.horizontal, PaddingSize.standard)
            .padding(.top, PaddingSize.tight)
        }
    }
    
    private var registerButton: some View {
        Button("register".localized()) {
            registerSuccess?()
            appState.showToast(item: UserMessageItem(
                animationName: "SuccessCircle",
                loopMode: .playOnce,
                title: "register_successfully".localized(),
                message: "please_login".localized()))
        }
        .padding(.horizontal, PaddingSize.standard)
        .buttonStyle(.primaryHButton)
        .disabled(!viewModel.isLoginButtonEnabled)
    }
}

#Preview {
    RegisterView(viewModel: RegisterViewModel(), registerSuccess: {
        
    })
    .environmentTheme(manager: ThemeManager.shared)
    .environment(AppState())
}
