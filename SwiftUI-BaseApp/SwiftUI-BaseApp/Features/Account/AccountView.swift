//
//  AccountView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct AccountView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(UserSettings.self) var userSettings
    @State private var viewModel: AccountViewModelProtocol
    var gotoSettings: VoidResult?
    var gotoProfile: VoidResult?
    var showLogin: VoidResult?
    
    init(vm: AccountViewModelProtocol, gotoSettings: VoidResult?, gotoProfile: VoidResult?, showLogin: VoidResult?) {
        viewModel = vm
        self.gotoProfile = gotoProfile
        self.gotoSettings = gotoSettings
        self.showLogin = showLogin
    }
    
    var body: some View {
        VStack {
            contentView(for: viewModel.viewState)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .setPrimaryBackground()
    }
}

extension AccountView {
    @ViewBuilder
    private func contentView(for viewState: AccountViewState) -> some View {
        if userSettings.hasLoggedIn {
            settingsContent()
                .overlay {
                    switch viewState {
                    case .initial:
                        EmptyView()
                    case .loading:
                        loadingView
                    case .loaded:
                        EmptyView()
                    }
                }
        } else {
            loginButton
        }
        
    }
    
    @ViewBuilder
    private func settingsContent() -> some View {
        VStack(spacing: 20) {
            Text("account_view".localized())
                .boldStyle(theme, size: TextSize.largeTitle, color: theme.color.textColor)
            
            Spacer()
                .frame(height: 30)
            
            Button {
                processGotoSubview(view: .settings)
            } label: {
                Text("settings".localized())
                    .boldStyle(theme, size: TextSize.title3, color: theme.color.textColor)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                processGotoSubview(view: .profile)
            } label: {
                Text("profile".localized())
                    .boldStyle(theme, size: TextSize.title3, color: theme.color.textColor)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var loginButton: some View {
        LoginButtonView {
            showLogin?()
        }
    }
    
    private var loadingView: some View {
        VStack {
            LoadingView(hideText: true)
        }
    }
    
    private func processGotoSubview(view: Router.MainTab) {
        Task {
            do {
                viewModel.loading(show: true)
                try await Task.sleep(for: .seconds(1))
                viewModel.loading(show: false)
                
                switch view {
                case .profile:
                    gotoProfile?()
                case .settings:
                    gotoSettings?()
                default: return
                }
            }
        }
    }
}

#Preview {
    AccountView(vm: AccountViewModel(), gotoSettings: nil, gotoProfile: nil, showLogin: nil)
        .environment(UserSettings())
}
