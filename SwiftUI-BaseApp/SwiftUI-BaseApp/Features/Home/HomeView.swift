//
//  HomeView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct HomeView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    var onShowProfile: VoidResult?
    var gotoSubview1: (() -> Void)?
    var gotoSubview2: (() -> Void)?
    var showSheet: VoidResult?
    var showFullScreen: VoidResult?
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                    .padding(.horizontal, 10)
                content
            }
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .setDefaultBackground()
    }
}

extension HomeView {
    
    @ViewBuilder
    private var headerView: some View {
        HeaderView(onShowProfile: onShowProfile, hasNewNotification: true)
    }
    
    @ViewBuilder
    private var content: some View {
        VStack(spacing: 20) {
            Text("home_view".localized())
                .boldStyle(theme, size: TextSize.largeTitle, color: theme.color.textColor)
            
            Spacer()
                .frame(height: 30)
            
            Button {
                processGotoSubview(subview: 1)
            } label: {
                Text("\("go_to_sub_view".localized()) 1")
                    .boldStyle(theme, size: TextSize.title3, color: theme.color.textColor)
                    .padding()
                    .frame(height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                processGotoSubview(subview: 2)
            } label: {
                Text("\("go_to_sub_view".localized()) 2")
                    .boldStyle(theme, size: TextSize.title3, color: theme.color.textColor)
                    .padding()
                    .frame(height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                showSheet?()
            } label: {
                Text("\("Test Show Sheet")")
                    .boldStyle(theme, size: TextSize.title3, color: theme.color.textColor)
                    .padding()
                    .frame(height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                showFullScreen?()
            } label: {
                Text("\("Test Show FullScreen")")
                    .boldStyle(theme, size: TextSize.title3, color: theme.color.textColor)
                    .padding()
                    .frame(height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
    }
    
    private func processGotoSubview(subview: Int) {
        if subview == 1 {
            gotoSubview1?()
        } else {
            gotoSubview2?()
        }
    }
    
}

#Preview {
    HomeView()
        .environmentTheme(manager: ThemeManager.shared)
        .environment(UserSettings())
}
