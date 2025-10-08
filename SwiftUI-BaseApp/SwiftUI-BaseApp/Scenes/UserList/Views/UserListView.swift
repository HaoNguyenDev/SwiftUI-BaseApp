//
//  UserListView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject private(set) var viewModel: GithubUserListVM
    var gotoUserDetail: SingleResult<GithubUserDetail>?
    @State private var navigate = false
    var body: some View {
        contentView()
            .padding([.top, .bottom])
            .setDefaultBackground()
    }
}

extension UserListView {
    @ViewBuilder
    func contentView() -> some View {
        ZStack {
            switch viewModel.viewState {
            case .initial:
                Color.clear
            case .loading:
                loadingView
            case .loaded(let users):
                GHUserList(users: users, didTapUser: { user in
                    fetchUserDetail(for: user)
                }, loadMoreFrom: { user in
                    processLoadMore(currentUser: user)
                })
            case .gotoDetail(let user):
                Color.clear
                    .onAppear {
                        gotoUserDetail?(user)
                    }
            case .error(let error):
                ErrorBanner(error: error) {
                    Task { await viewModel.fetchUsers() }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding()
            }
        }
        .onAppear() {
            Task {
                await viewModel.fetchUsers()
            }
        }
        .refreshable { await viewModel.fetchUsers() }
    }
    
    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding()
    }
}


extension UserListView {
    private func processLoadMore(currentUser user: GithubUser) {
        Task {
            await viewModel.loadMoreUser(currentUser: user)
        }
    }
    
    private func fetchUserDetail(for login: String?) {
        Task {
            await viewModel.fetchUserDetail(username: login)
        }
    }
}

#Preview {
    UserListView(viewModel: GithubUserListVM(), gotoUserDetail: nil)
        .environment(UserSettings())
}


struct GHUserList: View {
    var users: [GithubUser]
    var didTapUser: SingleResult<String?>?
    var loadMoreFrom: SingleResult<GithubUser>?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    UserRowView(user: user)
                        .padding()
                        .onAppear {
                            loadMoreFrom?(user)
                        }
                        .onTapGesture {
                            didTapUser?(user.login)
                        }
                }
            }
        }
    }
}
