//
//  SettingsView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct SettingsView: View {
    @Environment(UserSettings.self) var userSettings
    @State private var showChangeThemeModeView: Bool = false
    @State private var showChangeLanguageView: Bool = false
    var gotoChangeLanguageView: VoidResult?
    
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(spacing: 24) {
                Text("settings".localized())
                    .setFont(.bold, size: 32, color: userSettings.color.textColor)
                // Settings content
                VStack(spacing: 16) {
                    changeThemeModeRow
                    changeLanguageRow
                }
                Spacer()
            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setBlurBackgroundImage()
        .sheet(isPresented: $showChangeThemeModeView) {
            ThemeChangeView()
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
            /* TitleListView(title: "Choose theme mode",
             items: ThemeMode.allCases,
             onDismiss: {
             showChangeThemeModeView = false
             }, onSelectItem: { idx, item in
             changeTheme(mode: idx)
             showChangeThemeModeView = false
             })*/
        }
        .sheet(isPresented: $showChangeLanguageView) {
            TitleListView(title: "change_language_title".localized(),
                          items: LanguageCode.allCases,
             onDismiss: {
                showChangeLanguageView = false
             }, onSelectItem: { idx, item in
                 Logger.shared.debug("\(idx), \(item)")
                 updateLanguage(LanguageCode(rawValue: "\(item)"))
                 showChangeLanguageView = false
             })
            .presentationDetents([.height(410)])
            .presentationBackground(.clear)
        }
    }
    
    var changeThemeModeRow: some View {
        Button(action: {
            showChangeThemeModeView = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text("change_theme_mode".localized())
                        .setFont(.bold, size: 14.0, color: userSettings.color.textOnSubviewColor)
                }
                Spacer()
                Text(currentThemeMode)
                    .setFont(.bold, size: 14.0, color: userSettings.color.textOnSubviewColor)
                Image(systemName: "chevron.right").tint(userSettings.color.textOnSubviewColor)
            }
            .padding(.horizontal, 24)
            .frame(height: 75)
            .background(userSettings.color.subviewBgColor)
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
        .padding(.horizontal, 24)
    }
    
    var changeLanguageRow: some View {
        Button(action: {
//            gotoChangeLanguageView?()
            showChangeLanguageView = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text("change_language_title".localized())
                        .setFont(.bold, size: 14, color: userSettings.color.textOnSubviewColor)
                }
                Spacer()
                Text(currentLanguageTitle)
                    .setFont(.bold, size: 14.0, color: userSettings.color.textOnSubviewColor)
                Image(systemName: "chevron.right")
                    .tint(userSettings.color.textOnSubviewColor)
            }
            .padding(.horizontal, 24)
            .frame(height: 75)
            .background(userSettings.color.subviewBgColor)
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
        .padding(.horizontal, 24)
    }
    
    @MainActor
    private func updateLanguage(_ languageCode: LanguageCode?) {
        if let languageCode = languageCode {
            LanguageManager.shared.setLanguage(language: languageCode.getLanguage())
            userSettings.languageCode = "\(languageCode)"
        }
    }
}

extension SettingsView {
    var currentThemeMode: String {
        userSettings.colorSchemeOption.title
    }
    
    var currentLanguageTitle: String {
        guard let title = LanguageCode(rawValue: userSettings.languageCode)?.title else {
            return "Unknown"
        }
        return title
    }
}
#Preview {
    SettingsView(gotoChangeLanguageView: nil)
        .environment(UserSettings())
}
