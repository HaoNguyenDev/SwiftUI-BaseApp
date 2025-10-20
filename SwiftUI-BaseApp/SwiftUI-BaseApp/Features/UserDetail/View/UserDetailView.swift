//
//  UserDetailView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 1/9/25.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @ObservedObject var vm: UserDetailViewModel
    var gotoSubview: (() -> Void)?
    
    var body: some View {
        contentView()
    }
}

extension UserDetailView {
    @ViewBuilder
    func contentView() -> some View {
        ZStack(alignment: .top) {
            VStack {
                AvatarView(vm: vm)
                
                InfoSubview(vm: vm)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .setDefaultBackground()
    }
}

struct FollowerSubView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    var iconName: String = "person.fill"
    var count: String = "0"
    var title: String = "Follower"
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: iconName)
                .frame(width: 40, height: 40)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())
            Text(count)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(theme.color.textColor)
            Text(title)
                .font(.caption)
                .foregroundStyle(theme.color.textColor)
        }
    }
}

#Preview {
    UserDetailView(vm: UserDetailViewModel(user: GithubUserDetail()), gotoSubview: nil)
        .environment(UserSettings())
        .preferredColorScheme(.light)
}

struct AvatarView: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @ObservedObject var vm: UserDetailViewModel
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: vm.userDetail.avatarUrl.orEmpty)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure, .empty:
                    Image(systemName: "man-user-circle-icon")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    Image(systemName: "man-user-circle-icon")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 200, height: 200)
            .cornerRadius(100)
            .padding()
            
            Text(vm.userDetail.login.orEmpty)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(theme.color.textColor)
                .padding(.vertical, 10)
        }
    }
}

struct InfoSubview: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @ObservedObject var vm: UserDetailViewModel
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(theme.color.textColor, lineWidth: 1)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding()
                .overlay {
                    HStack(spacing: 80) {
                        FollowerSubView(count: vm.userDetail.getUserFollowers(), title: "Followers")
                        FollowerSubView(count: vm.userDetail.getUserFollowing(), title: "Following")
                    }
                }
        }
    }
}
