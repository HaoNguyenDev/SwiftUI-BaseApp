//
//  ThemeChangeView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct ThemeChangeView: View {
    @EnvironmentObject var settings: UserSettings
    @Environment(\.colorScheme) var systemColorScheme
    @Namespace private var animation
    private var isDarkMode: Bool = false
    var body: some View {
        VStack(spacing: 15) {
            Text("choose_theme".localized())
                .setFont(.bold, size: 25, color: settings.color.textOnSubviewColor)
            
            Image(systemName: settings.colorSchemeOption == .dark ? "moon.fill" : "sun.max.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(settings.color.bgColor)
            
            Text("\("current_theme".localized()) \(settings.colorSchemeOption.title)")
                .setFont(.regular, size: 17, color: settings.color.textOnSubviewColor)
            Text("choose_theme".localized())
                .setFont(.regular, size: 17, color: settings.color.textOnSubviewColor)
            
            HStack(spacing: 0) {
                ForEach(ColorSchemeOption.allCases, id: \.self) { theme in
                    Text(theme.rawValue)
                        .setFont(.semibold, size: 17, color: settings.colorSchemeOption == theme ? settings.color.textColor : settings.color.textOnSubviewColor)
                        .padding(.vertical, 10)
                        .frame(width: 100)
                        .background {
                            ZStack {
                                if settings.colorSchemeOption == theme {
                                    Capsule()
                                        .fill(settings.color.bgColor)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                }
                            }
                            .animation(.snappy, value: settings.colorSchemeOption)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            updateTheme(scheme: theme)
                        }
                }
            }
            .padding(5)
            .background(settings.color.mainTabUnselectedTextColor.opacity(0.3), in: .capsule)
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 410)
        .background {
            settings.color.subviewBgColor
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal, 10)
        .onAppear {
        }
        
    }
  
    private func updateTheme(scheme: ColorSchemeOption) {
        settings.setColorScheme(scheme, systemColorScheme: systemColorScheme)
    }
}

#Preview {
    ThemeChangeView()
        .environmentObject(UserSettings.shared)
        .colorScheme(.light)
}
