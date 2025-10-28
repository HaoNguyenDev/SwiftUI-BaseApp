//
//  UserRowView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    @Environment(\.theme) var theme
    var user: GithubUser
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top){
                idView
                // avatar part
                UserAvatar(urlString: user.avatarUrl)
                // info part
                infoView
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
    }
}

extension UserRowView {
    @ViewBuilder
    private var idView: some View {
        if let id = user.id {
            Text("\(id)")
                .regularStyle(theme, size: TextSize.caption1, color: theme.color.primaryText)
        } else {
            Text("id")
                .regularStyle(theme, size: TextSize.caption1, color: theme.color.primaryText)
        }
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
                Text("invalid_url".localized())
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

struct UserAvatar: View {
    private var url: URL?
    
    init(urlString: String?) {
        url = URL(string: urlString.orEmpty) ?? nil
    }
    
    var alreadyCached: Bool {
        guard let url else { return false }
        return ImageCache.default.isCached(forKey: url.absoluteString)
    }
    
    var body: some View {
        KFImage.url(url)
            .resizable()
            .onSuccess { r in
                print("Success: \(r.cacheType)")
            }
            .onFailure { e in
                print("Error \(e)")
            }
            .onProgress { downloaded, total in
                print("\(downloaded) / \(total))")
            }
            .placeholder {
                HStack {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(10)
                    Text("Loading...").font(.title)
                }
                .foregroundColor(.gray)
            }
            .fade(duration: 1)
            .cancelOnDisappear(true)
            .cacheMemoryOnly(true)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(RadiusSize.imageList)
    }
}
