//
//  ProfileView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var username: String = UserSettings.shared.username ?? "anonymous".localized()
}

struct ProfileView: View {
    @EnvironmentObject var settings: UserSettings
    @StateObject var model: ProfileViewModel = ProfileViewModel()
    
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
                
                Text(model.username)
                    .setFont(.bold, size: 32, color: settings.color.textColor)
                    .lineLimit(1)
                settingsView
                logoutView
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setBlurBackgroundImage()
    }
    
    @ViewBuilder
    var settingsView: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(systemName: "gear")
                Text("settings".localized())
                    .setFont(.bold, size: 14, color: settings.color.textOnSubviewColor)
                    
                Text("settings_description".localized())
                    .setFont(.regular, size: 10, color: settings.color.textOnSubviewColor)
            }
            
            Spacer()
            Image(systemName: "chevron.right.dotted.chevron.right")
        }
        .padding(.horizontal, 24)
        .frame(height: 107)
        .background(settings.color.subviewBgColor)
        .foregroundStyle(settings.color.textOnSubviewColor)
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
                    .tint(settings.color.textOnSubviewColor)
                Text("Log out")
                    .setFont(.bold, size: 14, color: settings.color.textOnSubviewColor)
                
                Text("You’ll be logged out of the app but can log back in anytime.")
                    .setFont(.regular, size: 10, color: settings.color.textOnSubviewColor)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right.dotted.chevron.right")
        }
        .padding(.horizontal, 24)
        .frame(height: 107)
        .background(settings.color.subviewBgColor)
        .foregroundStyle(settings.color.textOnSubviewColor)
        .cornerRadius(32)
        .padding(.horizontal, 32)
        .onTapGesture {
            showLogoutConfirmView?()
        }
    }
}

#Preview {
    ProfileView(model: ProfileViewModel(), showSettingsView: nil, showLogoutConfirmView: nil)
        .environmentObject(UserSettings.shared)
}
