//
//  LoginView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct LoginView: View {
    @Environment(AppState.self) var appState
    @Environment(\.theme) var theme: any ThemeProtocol
    @State var loginModel: LoginModel
    @State private var emailInput = ""
    @State private var passwordInput = ""
    @Environment(\.dismiss) private var dismiss
    var loginSuccess: SingleResult<LoginResult>?
    var gotoForgotPassword: VoidResult?
    var gotoRegister: VoidResult?
    
    init(loginModel: LoginModel,
         loginSuccess: SingleResult<LoginResult>?,
         forgotPassword: VoidResult?,
         register: VoidResult?) {
        self.loginModel = loginModel
        self.loginSuccess = loginSuccess
        self.gotoForgotPassword = forgotPassword
        self.gotoRegister = register
    }
    
    var body: some View {
        VStack {
            contentViewUI
                .overlay {
                    VStack {
                        switch loginModel.viewState {
                        case .content:
                            Color.clear
                        case .loading:
                            loadingView
                        case .success(let result):
                            Color.clear
                                .onAppear {
                                    handleLoginSuccess(result)
                                    loginModel.changeState(.content)
                                }
                        case .failure(let error):
                            Color.clear
                                .onAppear {
                                    handleLoginFailure(error)
                                    loginModel.changeState(.content)
                                }
                        }
                    }
                }
            
        }
        .fillMax()
        .ignoresSafeArea(.all)
        .setPrimaryBackground()
        .dismissKeyboardOnTap()
    }
}

extension LoginView {
    @ViewBuilder
    private var contentViewUI: some View {
        ScrollView {
            VStack(spacing: PaddingSize.standard) {
                closeButton
                loginTitle
                inputFields
                VStack(spacing: PaddingSize.standard){
                    loginButton
                    registerButton
                    forgotPasswordButton
                }
                dividerLine
                socialLoginButtons
                Spacer()
            }
        }
        .safeAreaPadding(.top)
        .setPrimaryBackground()
    }
}

//MARK: UI
extension LoginView {
    private var loadingView: some View {
        VStack {
            LoadingView()
        }
    }
    
    private var closeButton: some View {
        HStack(alignment: .center) {
            CloseButton(action: {
                dismiss()
            })
        }
        .frame(maxWidth: .infinity, maxHeight: HeightSize.headerIcon, alignment: .trailing)
    }
    
    private var loginTitle: some View {
        Text("login_title".localized())
            .boldStyle(theme, size: TextSize.largeTitle, color: theme.color.primaryText, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(PaddingSize.standard)
    }
    
    private var inputFields: some View {
        VStack(spacing: PaddingSize.standard) {
            HTextField(title: "Email",
                       placeholder: "Enter your email",
                       keyboardType: .emailAddress,
                       leftImage: theme.assets.iconEmail,
                       text: $emailInput,
                       errorMessage: .constant(nil))
            .padding(.horizontal, PaddingSize.standard)
            .padding(.bottom, PaddingSize.tight)
            
            HTextField(title: "Password",
                       placeholder: "Enter your password",
                       keyboardType: .default,
                       leftImage: theme.assets.iconPhone,
                       text: $passwordInput,
                       errorMessage: .constant(nil))
            .padding(.horizontal, PaddingSize.standard)
            .padding(.top, PaddingSize.tight)
        }
    }
    
    private var loginButton: some View {
        Button("login".localized()) {
            Task {
                await processLogin()
            }
        }
        .padding(.horizontal, PaddingSize.standard)
        .buttonStyle(.primaryHButton)
    }
    
    private var registerButton: some View {
        Button("register".localized()) {
            gotoRegister?()
        }
        .padding(.horizontal, PaddingSize.standard)
        .buttonStyle(.secondaryHButton)
    }
    
    private var forgotPasswordButton: some View {
        Button("forgot_password".localized()){
            gotoForgotPassword?()
        }
        .padding(.horizontal, PaddingSize.standard)
        .buttonStyle(.tertiaryHButton)
    }
    
    private var dividerLine: some View {
        HStack {
            Rectangle()
                .fill(theme.color.secondaryText2)
                .frame(height: HeightSize.line05px)
                .padding(.leading, PaddingSize.standard)
            
            Text("or")
                .regularStyle(theme, size: TextSize.footnote, color: theme.color.secondaryText2)
            
            Rectangle()
                .fill(theme.color.secondaryText2)
                .frame(height: HeightSize.line05px)
                .padding(.trailing, PaddingSize.standard)
        }
    }
    
    private var socialLoginButtons: some View {
        VStack {
            Button("Login with Apple".localized()){
                // TODO: Apple login
            }
            .padding(.horizontal, PaddingSize.standard)
            .buttonStyle(.tertiaryHButtonStyle(size: .large, leftSideIcon: theme.assets.iconApple))
            
            Button("Login with Google".localized()){
                // TODO: Google login
            }
            .padding(.horizontal, PaddingSize.standard)
            .buttonStyle(.tertiaryHButtonStyle(size: .large, leftSideIcon: theme.assets.iconGoogle))
            
            Button("Login with Telegram".localized()){
                // TODO: Telegram login
            }
            .padding(.horizontal, PaddingSize.standard)
            .buttonStyle(.tertiaryHButtonStyle(size: .large, leftSideIcon: theme.assets.iconTelegram))
        }
    }
}

//MARK: Actions
extension LoginView {
    private func processLogin() async {
        loginModel.doLogin()
    }
}

//MARK: Handler
extension LoginView {
    private func handleLoginSuccess(_ result: LoginResult) {
        Logger.shared.debug("Login Success: \(result)")
        loginSuccess?(result)
        
        appState.showToast(item: UserMessageItem(
            animationName: "SuccessCircle",
            loopMode: .playOnce,
            title: "login_success".localized(),
            message: "welcome_message_app".localized()))
    }
    
    private func handleLoginFailure(_ error: Error) {
        if let loginError = error as? LoginError {
            Logger.shared.error(loginError.errorMessage)
            appState.handleError(error: loginError.errorMessage, action: .toast)
        } else {
            Logger.shared.error(error.localizedDescription)
            appState.handleError(error: error.localizedDescription, action: .toast)
        }
    }
}

#Preview {
    LoginView(loginModel: LoginModel(userSettings: UserSettings()),
              loginSuccess: nil,
              forgotPassword: nil,
              register: nil)
    .environment(AppState())
    .environmentTheme(manager: ThemeManager.shared)
}
