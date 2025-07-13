//
//  LoginView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var loginModel: LoginModel
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
            if showLoading {
                loadingView
            } else {
                ZStack {
                    content
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
    private var content: some View {
        VStack {
            Text("Login View")
                .font(mainFont.bold(32))
                .foregroundStyle(themeManager.color.textColor)
            
            Spacer()
                .frame(height: 100)
            
            Button {
                Task {
                    await processLogin()
                }
            } label: {
                Text("Login")
                    .font(mainFont.bold(20))
                    .frame(width: 200, height: 50)
                    .foregroundStyle(themeManager.color.textColor)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                gotoRegister?()
            } label: {
                Text("Register")
                    .font(mainFont.bold(20))
                    .frame(width: 200, height: 50)
                    .foregroundStyle(themeManager.color.textColor)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                gotoForgotPassword?()
            } label: {
                Text("Forgot Password")
                    .font(mainFont.bold(20))
                    .frame(width: 200, height: 50)
                    .foregroundStyle(themeManager.color.textColor)
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
        
        Task {
            do {
                showLoading = true
                let loginResult = try await loginModel.doLogin()
                
                if !loginResult.username.isEmpty {
                    print(loginResult)
                    loginSuccess?(loginResult)
                    showLoading = false
                    appState.showToast( item: UserMessageItem(
                        animationName: "SuccessCircle",
                        loopMode: .playOnce,
                        title: "Login successfully",
                        message: "Welcome to App. Enjoy your trip and earn more gifts."))
                }
                
            } catch(let error as LoginError) {
                print(error.errorMessage)
                showLoading = false
                appState.handleError(error: error.errorMessage, action: .toast)
                /* appState.handleError(error: error,
                 action: .alert)
                 appState.showToast( item: UserMessageItem(
                 animationName: "SuccessCircle",
                 loopMode: .playOnce,
                 title: "Login successfully",
                 message: "Welcome to App. Enjoy your trip and earn more gifts."))*/
            }
            
        }
    }
    

}

#Preview {
    LoginView(loginModel: LoginModel(),
              loginSuccess: nil,
              forgotPassword: nil,
              register: nil)
    .environmentObject(AppState())
    .environmentObject(ThemeManager())
}
