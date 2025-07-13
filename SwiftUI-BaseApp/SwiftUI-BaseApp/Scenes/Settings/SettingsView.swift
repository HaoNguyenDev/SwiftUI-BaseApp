//
//  SettingsView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var theme: ThemeManager
    @State private var showChangeThemeModeView: Bool = false
    @State private var currentColorScheme: ColorScheme?
    var gotoChangeLanguageView: VoidResult?
    
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(spacing: 24) {
                Text("Settings").set(font: mainFont.bold(32), and: theme.color.textColor)
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
        .setDefaultBackground()
        .sheet(isPresented: $showChangeThemeModeView) {
//            ThemeChangeView()
//                .presentationDetents([.height(410)])
//                .presentationBackground(.clear)
            /* TitleListView(title: "Choose theme mode",
             items: ThemeMode.allCases,
             onDismiss: {
             showChangeThemeModeView = false
             }, onSelectItem: { idx, item in
             changeTheme(mode: idx)
             showChangeThemeModeView = false
             })*/
        }
    }
    
    var changeThemeModeRow: some View {
        Button(action: {
            showChangeThemeModeView = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Change theme mode").set(font: mainFont.bold(14), and: theme.color.textSubviewColor)
                }
                Spacer()
                Image(systemName: "chevron.right").tint(theme.color.textSubviewColor)
            }
            .padding(.horizontal, 24)
            .frame(height: 75)
            .background(theme.color.subviewBgColor)
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
        .padding(.horizontal, 24)
    }
    
    var changeLanguageRow: some View {
        Button(action: {
            gotoChangeLanguageView?()
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Change language").set(font: mainFont.bold(14), and: theme.color.textSubviewColor)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .tint(theme.color.textSubviewColor)
            }
            .padding(.horizontal, 24)
            .frame(height: 75)
            .background(theme.color.subviewBgColor)
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    SettingsView(gotoChangeLanguageView: nil)
        .environmentObject(ThemeManager())
        .environmentObject(UserSettings.shared)
}
