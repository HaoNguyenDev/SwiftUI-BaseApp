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
    
    var showSettingsView: VoidResult?
    var showLogoutView: VoidResult?
    
    init(userSettings: UserSettings,
         showSettingsView: VoidResult?,
         showLogoutView: VoidResult?) {
        self._viewModel = State(initialValue: ProfileViewModel(userSettings: userSettings))
        self.showSettingsView = showSettingsView
        self.showLogoutView = showLogoutView
    }
    
    var body: some View {
        mainContent
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
                    .boldStyle(theme, size: TextSize.callout, color: theme.color.textOnSubviewColor)
                
                Text("settings_description".localized())
                    .regularStyle(theme, size: TextSize.footnote, color: theme.color.textOnSubviewColor)
            }
            
            Spacer()
            Image(systemName: "chevron.right.dotted.chevron.right")
        }
        .padding(.horizontal, 24)
        .frame(height: 107)
        .background(theme.color.subviewBgColor)
        .foregroundStyle(theme.color.textOnSubviewColor)
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
                    .tint(theme.color.textOnSubviewColor)
                Text("logout".localized())
                    .boldStyle(theme, size: TextSize.callout, color: theme.color.textOnSubviewColor)
                
                Text("logout_description".localized())
                    .regularStyle(theme, size: TextSize.footnote, color: theme.color.textOnSubviewColor)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right.dotted.chevron.right")
        }
        .padding(.horizontal, 24)
        .frame(height: 107)
        .background(theme.color.subviewBgColor)
        .foregroundStyle(theme.color.textOnSubviewColor)
        .cornerRadius(32)
        .padding(.horizontal, 32)
        .onTapGesture {
            showLogoutView?()
        }
    }
}

#Preview {
    ProfileView(userSettings: UserSettings(), showSettingsView: nil, showLogoutView: nil)
        .environment(UserSettings())
}
