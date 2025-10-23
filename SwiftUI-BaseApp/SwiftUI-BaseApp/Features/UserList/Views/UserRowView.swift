//
//  UserRowView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct UserRowView: View {
    @Environment(\.theme) var theme
    var user: GithubUser
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top){
                // avatar part
                avatarView
                // info part
                infoView
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

extension UserRowView {
    private var avatarView: some View {
        HStack(spacing: 10) {
            
            if let id = user.id {
                Text("\(id)")
                    .foregroundStyle(.black)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            AsyncImage(url: URL(string: user.avatarUrl ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure, .empty:
                    Image(uiImage: theme.assets.userAvatar)
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    Image(uiImage: theme.assets.userAvatar)
                        .resizable()
                        .scaledToFit()
                }
            }
            .cornerRadius(10)
            
            //            WebImage(url: URL(string: user.avatarUrl ?? ""))
            //                .resizable()
            //                .scaledToFit()
            //                .cornerRadius(10)
        }
        .frame(maxWidth: 100, maxHeight: 100)
        
        .padding([.leading, .top, .bottom], 10)
    }
}

extension UserRowView {
    private var infoView: some View {
        VStack(alignment: .leading) {
            Text(user.login ?? "" .uppercased())
                .boldStyle(theme, size: TextSize.headline, color: Color.black, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            if let urlString = user.url, let url = URL(string: urlString) {
                Link(urlString, destination: url)
                    .font(.system(size: 12))
            } else {
                Text("Invalid URL")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.blue)
                    .font(.system(size: 12))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
    }
}

#Preview {
    UserRowView(user: GithubUser(id: 1, login: "Hao", avatarUrl: "avatarUrl", url: "url" ))
}
