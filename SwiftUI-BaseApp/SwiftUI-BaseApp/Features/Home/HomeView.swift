//
//  HomeView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct HomeView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(UserSettings.self) var userSettings
    var showLogin: VoidResult?
    var onShowProfile: VoidResult?
    var gotoSubview1: SingleResult<String?>?
    var gotoSubview2: SingleResult<String?>?
    var showSheet: VoidResult?
    var showFullScreen: VoidResult?
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                    .padding(.horizontal, PaddingSize.standard)
                content
            }
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .setPrimaryBackground()
    }
}

extension HomeView {
    
    @ViewBuilder
    private var headerView: some View {
        HeaderView(onShowProfile: onShowProfile, onShowLogin: showLogin, hasNewNotification: true)
    }
    
    @ViewBuilder
    private var content: some View {
        if userSettings.hasLoggedIn {
            homeContent
        } else {
            loginButton
        }
    }
    
    private var loginButton: some View {
        LoginButtonView(size: .medium) {
            showLogin?()
        }
    }
    
    private var homeContent: some View {
        VStack(spacing: PaddingSize.wide) {
            Text("home_view".localized())
                .boldStyle(theme, size: TextSize.largeTitle, color: theme.color.textColor)
            
            Spacer()
                .frame(height: 30)
            
            Button("\("go_to_sub_view".localized()) 1") {
                processGotoSubview(view: .subview1(info: "This's parameter"))
            }
            .padding(.horizontal, PaddingSize.standard)
            .buttonStyle(.primaryHButton)
            
            Button("\("go_to_sub_view".localized()) 2") {
                processGotoSubview(view: .subview1(info: "This's parameter"))
            }
            .padding(.horizontal, PaddingSize.standard)
            .buttonStyle(.primaryHButton)
            
            Button("show_sheet".localized()) {
                showSheet?()
            }
            .padding(.horizontal, PaddingSize.standard)
            .buttonStyle(.primaryHButton)
            
            Button("show_fullscreen".localized()) {
                showFullScreen?()
            }
            .padding(.horizontal, PaddingSize.standard)
            .buttonStyle(.primaryHButton)

        }
    }
    
    private func processGotoSubview(view: Router.MainTab) {
        switch view {
        case .subview1(let info):
            gotoSubview1?(info)
        case .subview2(let info):
            gotoSubview2?(info)
        default: break
        }
    }
    
}

#Preview {
    HomeView()
        .environmentTheme(manager: ThemeManager.shared)
        .environment(UserSettings())
}
