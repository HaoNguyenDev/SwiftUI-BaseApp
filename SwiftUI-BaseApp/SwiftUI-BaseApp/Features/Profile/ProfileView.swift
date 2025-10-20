//
//  ProfileView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(UserSettings.self) var userSettings
    @Environment(\.theme) var theme: any ThemeProtocol
    let showSettingsView: VoidResult?
    let showLogoutConfirmView: VoidResult?

    var body: some View {
        ScrollView {
            VStack {
                Group {
                    Image(uiImage: .appLogo)
                            .resizable()
                }
                .frame(width: 128, height: 128)
                .padding(.top, 32)
                
                Text(userSettings.username ?? "anonymous".localized())
                    .font(theme.font.bold(ofSize: 32))
                    .foregroundStyle(theme.color.textColor)
                    .lineLimit(1)
                settingsView
                logoutView
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setDefaultBackground()
    }
    
    @ViewBuilder
    var settingsView: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(systemName: "gear")
                Text("settings".localized())
                    .font(theme.font.bold(ofSize: 14))
                    .foregroundStyle(theme.color.textOnSubviewColor)
                    
                Text("settings_description".localized())
                    .font(theme.font.bold(ofSize: 10))
                    .foregroundStyle(theme.color.textOnSubviewColor)
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
                    .font(theme.font.bold(ofSize: 14))
                    .foregroundStyle(theme.color.textOnSubviewColor)
                
                Text("logout_description".localized())
                    .font(theme.font.regular(ofSize: 14))
                    .foregroundStyle(theme.color.textOnSubviewColor)
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
            showLogoutConfirmView?()
        }
    }
}

#Preview {
    ProfileView(showSettingsView: nil, showLogoutConfirmView: nil)
        .environment(UserSettings())
}
