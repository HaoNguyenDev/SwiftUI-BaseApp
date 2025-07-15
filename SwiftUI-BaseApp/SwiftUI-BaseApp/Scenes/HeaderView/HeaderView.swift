//
//  HeaderView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var theme: ThemeManager
    let onShowProfile: VoidResult?
    var name: String? {
        UserSettings.shared.username
    }
    var avatar: String? {
        ""
    }
    @State var hasNewNotification: Bool = false
    var body: some View {
        HStack(spacing: 24) {
            HStack(spacing: 4) {
                Image(uiImage: .appLogo)
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Text("👋 Hi, \(name ?? "buddy".localized())")
                    .foregroundStyle(theme.color.textColor)
                    .font(mainFont.bold(14))
                    .lineLimit(1)
            }
            .onTapGesture { onShowProfile?() }
            
            Spacer(minLength: 1)
            
            HStack(spacing: 12) {
                Button(
                    action: {
//                        NotificationCenter.default.post(name: .showNotificationScreen, object: nil)
                    },
                    label: {
                        Image(systemName: hasNewNotification ? "bell.badge" : "bell")
                            .symbolRenderingMode(.monochrome)
                            .symbolEffect(.wiggle, options: .repeat(.bitWidth))
                            .foregroundStyle(theme.color.textColor)
                            .font(mainFont.semibold(18))
                    })
                    
                HStack(alignment: .center, spacing: 5) {
                        Text("100.000.000")
                            .font(mainFont.bold(14))
                            .foregroundStyle(theme.color.textOnSubviewColor)
                            .fixedSize(horizontal: true, vertical: false)
                        Image(systemName: "bitcoinsign.circle")
//                            .resizable()
                            .font(mainFont.semibold(18))
                            .foregroundStyle(theme.color.textOnSubviewColor)
                    }
                
                .padding(.horizontal, 8)
                .frame(height: 32)
                .background(theme.color.subviewBgColor, in: .rect(cornerRadius: 16))
                .onTapGesture {
//                    NotificationCenter.default.post(name: .showTransactionHistoryScreen, object: nil)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    HeaderView(onShowProfile: nil)
        .setDefaultBackground()
        .environmentObject(ThemeManager())
}
