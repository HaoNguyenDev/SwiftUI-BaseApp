//
//  AccountView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct AccountView: View {
    @Environment(UserSettings.self) var settings
    @State private var showLoading: Bool = false
    
    var gotoSettings: (() -> Void)?
    var gotoProfile: (() -> Void)?
    
    var body: some View {
        VStack {
            if showLoading {
                loadingView
            } else {
                content
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .setBlurBackgroundImage()
    }
}

extension AccountView {
    @ViewBuilder
    private var content: some View {
        VStack(spacing: 20) {
            Text("account_view".localized())
                .setFont(.bold, size: 32, color: settings.color.textColor)
            
            Spacer()
                .frame(height: 30)
            
            Button {
                processGotoSubview(subview: 1)
            } label: {
                Text("settings".localized())
                    .setFont(.bold, size: 20, color: settings.color.textColor)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                processGotoSubview(subview: 2)
            } label: {
                Text("profile".localized())
                    .setFont(.bold, size: 20, color: settings.color.textColor)
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        VStack {
            LoadingView()
        }
    }
    
    private func processGotoSubview(subview: Int) {
        showLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if subview == 1 {
                gotoSettings?()
            } else {
                gotoProfile?()
            }
            showLoading = false
        }
    }
}

#Preview {
    AccountView()
}
