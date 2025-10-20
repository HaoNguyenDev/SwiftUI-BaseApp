//
//  ThemeChangeView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct ThemeChangeView: View {
    @Environment(UserSettings.self) var userSettings
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(\.colorScheme) var systemColorScheme
    @Namespace private var animation
    private var isDarkMode: Bool = false
    var body: some View {
        VStack(spacing: 15) {
            Text("choose_theme".localized())
                .setFont(.bold, size: 25, color: theme.color.textOnSubviewColor)
            
            Image(systemName: themeIcon(userSettings.colorSchemeOption))
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(theme.color.bgColor)
            
            Text("\("current_theme".localized()) \(userSettings.colorSchemeOption.title)")
                .setFont(.regular, size: 17, color: theme.color.textOnSubviewColor)
            Text("choose_theme".localized())
                .setFont(.regular, size: 17, color: theme.color.textOnSubviewColor)
            
            themeSelection
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 410)
        .background {
            theme.color.subviewBgColor
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal, 10)
        .onAppear {
        }
        
    }
    
    private var themeSelection: some View {
        HStack(spacing: 0) {
            ForEach(ColorSchemeOption.allCases, id: \.self) { schemeOption in
                Text(schemeOption.title)
                    .setFont(.semibold,
                             size: 17,
                             color: userSettings.colorSchemeOption == schemeOption ? theme.color.textColor : theme.color.textOnSubviewColor)
                    .padding(.vertical, 10)
                    .frame(width: 100)
                    .background {
                        activeTabBackground(for: schemeOption)
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        updateTheme(scheme: schemeOption)
                    }
            }
        }
        .padding(5)
        .background(theme.color.mainTabUnselectedTextColor.opacity(0.3), in: .capsule)
        .animation(.snappy, value: userSettings.colorSchemeOption)
    }
    
    private func activeTabBackground(for option: ColorSchemeOption) -> some View {
        ZStack {
            if userSettings.colorSchemeOption == option {
                Capsule()
                    .fill(theme.color.bgColor)
                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
            }
        }
    }
    
    private func themeIcon(_ theme: ColorSchemeOption) -> String {
        switch theme {
        case .dark: return "moon.fill"
        case .light: return "sun.max.fill"
        case .system: return "autostartstop.trianglebadge.exclamationmark"
        }
    }
  
    private func updateTheme(scheme: ColorSchemeOption) {
        userSettings.setColorScheme(scheme, systemColorScheme: systemColorScheme)
    }
}

#Preview {
    ThemeChangeView()
        .environment(UserSettings())
        .colorScheme(.light)
}
