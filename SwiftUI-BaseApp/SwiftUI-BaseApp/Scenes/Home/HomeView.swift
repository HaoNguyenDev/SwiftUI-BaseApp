//
//  HomeView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 13/7/25.
//


import SwiftUI

struct HomeView: View {
    @Environment(UserSettings.self) var userSettings
    var onShowProfile: VoidResult?
    var gotoSubview1: (() -> Void)?
    var gotoSubview2: (() -> Void)?
    var showSheet: VoidResult?
    var showFullScreen: VoidResult?
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                    .padding(.horizontal, 20)
                content
            }
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .setBlurBackgroundImage()
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
                .setFont(.bold, size: 32, color: userSettings.color.textColor)
            
            Spacer()
                .frame(height: 30)
            
            Button {
                processGotoSubview(subview: 1)
            } label: {
                Text("\("go_to_sub_view".localized()) 1")
                    .setFont(.bold, size: 20, color: userSettings.color.textColor)
                    .padding()
                    .frame(height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                processGotoSubview(subview: 2)
            } label: {
                Text("\("go_to_sub_view".localized()) 2")
                    .setFont(.bold, size: 20, color: userSettings.color.textColor)
                    .padding()
                    .frame(height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                showSheet?()
            } label: {
                Text("\("Test Show Sheet")")
                    .setFont(.bold, size: 20, color: userSettings.color.textColor)
                    .padding()
                    .frame(height: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                showFullScreen?()
            } label: {
                Text("\("Test Show FullScreen")")
                    .setFont(.bold, size: 20, color: userSettings.color.textColor)
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
        .environment(UserSettings())
}
