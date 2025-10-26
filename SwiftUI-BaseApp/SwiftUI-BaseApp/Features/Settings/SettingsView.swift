//
//  SettingsView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct SettingsView: View {
    @Environment(UserSettings.self) var userSettings
    @Environment(\.theme) var theme: any ThemeProtocol
    @State private var showChangeThemeModeView: Bool = false
    @State private var showChangeLanguageView: Bool = false
    
    var body: some View {
        contentView()
        .sheet(isPresented: $showChangeThemeModeView) {
            ThemeChangeView()
                .presentationDetents([.height(450)])
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
                 Logger.shared.info("\(idx), \(item)")
                 updateLanguage(LanguageCode(rawValue: "\(item)"))
                 showChangeLanguageView = false
             })
            .presentationDetents([.height(410)])
            .presentationBackground(.clear)
        }
    }
}

// MARK: - UI
extension SettingsView {
    @ViewBuilder
    private func contentView() -> some View {
        ScrollView(showsIndicators: false, content: {
            VStack(spacing: 24) {
                Text("settings".localized())
                    .boldStyle(theme, size: TextSize.largeTitle, color: theme.color.textColor)
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
        .setPrimaryBackground()
    }
    
    private var changeThemeModeRow: some View {
        Button(action: {
            showChangeThemeModeView = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text("change_theme_mode".localized())
                        .boldStyle(theme, size: TextSize.subhead, color: theme.color.primaryText)
                }
                Spacer()
                Text(currentThemeMode)
                    .boldStyle(theme, size: TextSize.subhead, color: theme.color.primaryText)
                
                Image(systemName: "chevron.right").tint(theme.color.primaryText)
            }
            .padding(.horizontal, 24)
            .frame(height: 75)
            .background(theme.color.secondaryBg)
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
        .padding(.horizontal, 24)
    }
    
    var changeLanguageRow: some View {
        Button(action: {
            showChangeLanguageView = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text("change_language_title".localized())
                        .boldStyle(theme, size: TextSize.subhead, color: theme.color.primaryText)
                }
                Spacer()
                Text(currentLanguageTitle)
                    .boldStyle(theme, size: TextSize.subhead, color: theme.color.primaryText)
                Image(systemName: "chevron.right")
                    .tint(theme.color.primaryText)
            }
            .padding(.horizontal, 24)
            .frame(height: 75)
            .background(theme.color.secondaryBg)
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
        .padding(.horizontal, 24)
    }
}

extension SettingsView {
    private var currentThemeMode: String {
        userSettings.colorSchemeOption.title
    }
    
    private var currentLanguageTitle: String {
        guard let title = LanguageCode(rawValue: userSettings.languageCode ?? LanguageCode.eng.rawValue)?.title else {
            return "Unknown"
        }
        return title
    }
    
    @MainActor
    private func updateLanguage(_ languageCode: LanguageCode?) {
        if let languageCode = languageCode {
            LanguageManager.shared.setLanguage(language: languageCode.getLanguage())
            userSettings.languageCode = "\(languageCode)"
        } else {
            userSettings.languageCode = LanguageCode.eng.rawValue
        }
    }
}
#Preview {
    SettingsView()
        .environment(UserSettings())
        .environmentTheme(manager: ThemeManager.shared)
}
