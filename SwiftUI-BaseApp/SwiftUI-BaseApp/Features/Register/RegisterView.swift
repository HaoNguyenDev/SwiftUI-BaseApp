//
//  RegisterView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 27/10/25.
//

import SwiftUI

@Observable class RegisterViewModel: ViewStateable {
   
    var viewState: ViewState
    
    init() {
        self.viewState = .initial
    }
    
}

// MARK: ViewStateable
extension RegisterViewModel {
    enum ViewState {
        case initial
        case content
        case loading
        case failed(Error)
        case success
    }
    
    func changeState(_ newState: ViewState) {
        viewState = newState
    }
}


struct RegisterView: View {
    @Environment(AppState.self) var appState
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: RegisterViewModel
    @State private var emailInput = ""
    @State private var passwordInput = ""
    
    private let registerSuccess: VoidResult?
    
    init(viewModel: RegisterViewModel,
         registerSuccess: VoidResult?) {
        self.viewModel = viewModel
        self.registerSuccess = registerSuccess
    }
    
    var body: some View {
        VStack {
            contentView
        }
        .fillMax()
        .setPrimaryBackground()
    }
    
    
    
}

// MARK: - UI
extension RegisterView {
    private var contentView: some View {
        ScrollView {
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
                       leftImage: theme.assets.iconPassword,
                       text: $passwordInput,
                       errorMessage: .constant(nil))
            .padding(.horizontal, PaddingSize.standard)
            .padding(.top, PaddingSize.tight)
        }
    }
    
    private var registerButton: some View {
        Button("register".localized()) {
            registerSuccess?()
            appState.showInform(message: UserMessageItem(title: "Successfully".localized(), message: "Register successfully"), autoDissmissAfter: 1.5)
        }
        .padding(.horizontal, PaddingSize.standard)
        .buttonStyle(.primaryHButton)
    }
}

#Preview {
    RegisterView(viewModel: RegisterViewModel(), registerSuccess: {
        
    })
    .environmentTheme(manager: ThemeManager.shared)
    .environment(AppState())
}
