//
//  ProfileView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @State private var viewModel: ProfileViewModel
    @State private var showLogoutView = false
    @State private var shouldPopToRoot = false
    var showSettingsView: VoidResult?
    var popToRoot: VoidResult?
    
    init(viewModel: ProfileViewModel,
         showSettingsView: VoidResult?,
         popToRoot: VoidResult?) {
        self.viewModel = viewModel
        self.showSettingsView = showSettingsView
        self.popToRoot = popToRoot
    }
    
    var body: some View {
        mainContent
            .sheet(isPresented: $showLogoutView) {
                LogoutConfirmView(onLogout: {
                    viewModel.doLogout()
                    shouldPopToRoot = true
                    showLogoutView = false
                }, onDismiss: {
                    showLogoutView = false
                })
                .presentationDetents([.height(450)])
                .presentationBackground(.clear)
                .onDisappear {
                    if shouldPopToRoot {
                        popToRoot?()
                        shouldPopToRoot = false
                        NotificationCenter.default.post(name: .showHomeScreen, object: nil)
                    }
                }
            }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        ScrollView {
            VStack {
                Group {
                    Image(uiImage: .appLogo)
                        .resizable()
                }
                .frame(width: 128, height: 128)
                .padding(.top, 32)
                
                Text(viewModel.username ?? "anonymous".localized())
                    .boldStyle(theme, size: TextSize.largeTitle, color: theme.color.textColor)
                    .lineLimit(1)
                settingsView
                logoutView
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setPrimaryBackground()
    }
    
    @ViewBuilder
    var settingsView: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(systemName: "gear")
                Text("settings".localized())
                    .boldStyle(theme, size: TextSize.callout, color: theme.color.primaryText)
                
                Text("settings_description".localized())
                    .regularStyle(theme, size: TextSize.footnote, color: theme.color.primaryText)
            }
            
            Spacer()
            Image(systemName: "chevron.right.dotted.chevron.right")
        }
        .padding(.horizontal, 24)
        .frame(height: 107)
        .background(theme.color.secondaryBg)
        .foregroundStyle(theme.color.primaryText)
        .cornerRadius(32)
        .padding(.horizontal, 32)
        .onTapGesture {
            showSettingsView?()
        }
    }
    
    @ViewBuilder
    var logoutView: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .tint(theme.color.primaryText)
                Text("logout".localized())
                    .boldStyle(theme, size: TextSize.callout, color: theme.color.primaryText)
                
                Text("logout_description".localized())
                    .regularStyle(theme, size: TextSize.footnote, color: theme.color.primaryText)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right.dotted.chevron.right")
        }
        .padding(.horizontal, 24)
        .frame(height: 107)
        .background(theme.color.secondaryBg)
        .foregroundStyle(theme.color.primaryText)
        .cornerRadius(32)
        .padding(.horizontal, 32)
        .onTapGesture {
            showLogoutView = true
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(userSettings: UserSettings()), showSettingsView: nil, popToRoot: nil)
        .environment(UserSettings())
}
