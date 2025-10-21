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
    @State private var showLoading: Bool = false
    
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
            VStack {
                switch loginModel.viewState {
                case .content:
                    loginContentView
                case .loading:
                    loadingView
                case .success(let result):
                    Color.clear
                        .onAppear {
                            handleLoginSuccess(result)
                            loginModel.viewState = .content
                        }
                case .failure(let error):
                    Color.clear
                        .onAppear {
                            handleLoginFailure(error)
                            loginModel.viewState = .content
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .setDefaultBackground()
    }
}

extension LoginView {
    @ViewBuilder
    private var loginContentView: some View {
        VStack {
            Text("login_view".localized())
                .boldStyle(theme, size: 32, color: theme.color.textColor)
            Spacer()
                .frame(height: 100)
            
            Button {
                Task {
                    await processLogin()
                }
            } label: {
                Text("login".localized())
                    .boldStyle(theme, size: 20, color: theme.color.textColor)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                gotoRegister?()
            } label: {
                Text("register".localized())
                    .boldStyle(theme, size: 20, color: theme.color.textColor)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                gotoForgotPassword?()
            } label: {
                Text("forgot_password".localized())
                    .boldStyle(theme, size: 20, color: theme.color.textColor)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        VStack {
            LoadingView()
        }
    }
    
    private func processLogin() async {
        loginModel.doLogin()
    }
    
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
}
