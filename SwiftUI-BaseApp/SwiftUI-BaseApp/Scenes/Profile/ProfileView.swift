//
//  ProfileView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(UserSettings.self) var userSettings
    
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
                    .setFont(.bold, size: 32, color: userSettings.theme.textColor)
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
                    .setFont(.bold, size: 14, color: userSettings.theme.textOnSubviewColor)
                    
                Text("settings_description".localized())
                    .setFont(.regular, size: 10, color: userSettings.theme.textOnSubviewColor)
            }
            
            Spacer()
            Image(systemName: "chevron.right.dotted.chevron.right")
        }
        .padding(.horizontal, 24)
        .frame(height: 107)
        .background(userSettings.theme.subviewBgColor)
        .foregroundStyle(userSettings.theme.textOnSubviewColor)
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
                    .tint(userSettings.theme.textOnSubviewColor)
                Text("Log out")
                    .setFont(.bold, size: 14, color: userSettings.theme.textOnSubviewColor)
                
                Text("You’ll be logged out of the app but can log back in anytime.")
                    .setFont(.regular, size: 10, color: userSettings.theme.textOnSubviewColor)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right.dotted.chevron.right")
        }
        .padding(.horizontal, 24)
        .frame(height: 107)
        .background(userSettings.theme.subviewBgColor)
        .foregroundStyle(userSettings.theme.textOnSubviewColor)
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
