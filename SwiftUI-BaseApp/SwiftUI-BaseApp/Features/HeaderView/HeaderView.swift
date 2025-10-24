//
//  HeaderView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct HeaderView: View {
    @Environment(UserSettings.self) var userSettings
    @Environment(\.theme) var theme: any ThemeProtocol
    let onShowProfile: VoidResult?
    var name: String? {
        userSettings.username
    }
    var avatar: String? {
        ""
    }
    @State var hasNewNotification: Bool = false
    var body: some View {
        HStack(spacing: PaddingSize.medium) {
            HStack(spacing: 4) {
                Image(uiImage: .appLogo)
                    .resizable()
                    .frame(width: 32, height: 32)
                
                nameView()
                    .boldStyle(theme, size: TextSize.subhead, color: theme.color.primaryText)
                    .lineLimit(1)
            }
            .onTapGesture { onShowProfile?() }
            
            Spacer(minLength: 1)
            
            HStack(spacing: PaddingSize.standard) {
                Button(
                    action: {
                        //                        NotificationCenter.default.post(name: .showNotificationScreen, object: nil)
                    },
                    label: {
                        Image(systemName: hasNewNotification ? "bell.badge" : "bell")
                            .symbolRenderingMode(.monochrome)
                            .symbolEffect(.wiggle, options: .repeat(.bitWidth))
                            .foregroundStyle(theme.color.primaryText)
                            .font(theme.font.semibold(ofSize: TextSize.title3))
                    })
                
                HStack(alignment: .center, spacing: 5) {
                    Text("100.000.000")
                        .boldStyle(theme, size: TextSize.subhead, color: theme.color.primaryText)
                        .fixedSize(horizontal: true, vertical: false)
                    Image(systemName: "bitcoinsign.circle")
//                                                .resizable()
                        .font(theme.font.semibold(ofSize: TextSize.headline))
                        .foregroundStyle(theme.color.primaryText)
                }
                .padding(.horizontal, 8)
                .frame(height: 32)
                .background(theme.color.secondaryBg, in: .rect(cornerRadius: 16))
                .onTapGesture {
                    //                    NotificationCenter.default.post(name: .showTransactionHistoryScreen, object: nil)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
    }
    
    
    private func nameView() -> Text {
        if let name = userSettings.username {
            return Text("Hi, \(name)")
        }
        return Text("Login, please!")
    }
}

#Preview {
    HeaderView(onShowProfile: nil)
        .setPrimaryBackground()
        .environmentTheme(manager: ThemeManager.shared)
        .environment(UserSettings())
}
