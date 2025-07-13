//
//  ThemeChangeView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct ThemeChangeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var systemColorScheme
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Choose Theme")
                .font(mainFont.bold(25))
                .foregroundStyle(themeManager.color.textOnSubviewColor)
            
            Text("Current Theme: \(themeManager.colorSchemeOption.title)")
                .font(mainFont.regular(17))
                .foregroundStyle(themeManager.color.textOnSubviewColor)
            
            HStack(spacing: 0) {
                ForEach(ColorSchemeOption.allCases, id: \.self) { theme in
                    Text(theme.rawValue)
                        .font(mainFont.semibold(17))
                        .foregroundStyle(themeManager.colorSchemeOption == theme ? themeManager.color.textColor : themeManager.color.textOnSubviewColor)
                        .padding(.vertical, 10)
                        .frame(width: 100)
                        .background {
                            ZStack {
                                if themeManager.colorSchemeOption == theme {
                                    Capsule()
                                        .fill(themeManager.color.bgColor)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                }
                            }
                            .animation(.snappy, value: themeManager.colorSchemeOption)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            updateTheme(scheme: theme)
                        }
                }
            }
            .padding(5)
            .background(themeManager.color.mainTabUnselectedTextColor.opacity(0.3), in: .capsule)
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 410)
        .background(themeManager.color.subviewBgColor)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal, 10)
        
    }
  
    private func updateTheme(scheme: ColorSchemeOption) {
        themeManager.colorSchemeOption = scheme
//        themeManager.updateTheme(scheme, systemColorScheme: systemColorScheme)
    }
}

#Preview {
    ThemeChangeView()
        .environmentObject(ThemeManager())
}
