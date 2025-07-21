//
//  SettingsView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var settings: UserSettings
    @State private var showChangeThemeModeView: Bool = false
    @State private var showChangeLanguageView: Bool = false
    @State private var currentColorScheme: ColorScheme?
    var gotoChangeLanguageView: VoidResult?
    
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(spacing: 24) {
                Text("settings".localized()).set(font: mainFont.bold(32), and: settings.color.textColor)
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
                 updateLanguage(value: idx)
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
                    Text("change_theme_mode".localized()).set(font: mainFont.bold(14), and: settings.color.textOnSubviewColor)
                }
                Spacer()
                Image(systemName: "chevron.right").tint(settings.color.textOnSubviewColor)
            }
            .padding(.horizontal, 24)
            .frame(height: 75)
            .background(settings.color.subviewBgColor)
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
                    Text("change_language_title".localized()).set(font: mainFont.bold(14), and: settings.color.textOnSubviewColor)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .tint(settings.color.textOnSubviewColor)
            }
            .padding(.horizontal, 24)
            .frame(height: 75)
            .background(settings.color.subviewBgColor)
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
        .padding(.horizontal, 24)
    }
    
    @MainActor
    private func updateLanguage(value: Int) {
        LanguageManager.shared.setLanguage(language: LanguageCode(rawValue: value)?.getLanguage() ?? LanguageCode.english.getLanguage())
    }
}

#Preview {
    SettingsView(gotoChangeLanguageView: nil)
        .environmentObject(UserSettings.shared)
}
