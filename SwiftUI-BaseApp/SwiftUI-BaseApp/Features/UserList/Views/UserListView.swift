//
//  UserListView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//

import SwiftUI

struct UserListView: View {
    @Environment(UserSettings.self) var userSettings
    @ObservedObject private(set) var viewModel: GithubUserListVM
    var gotoUserDetail: SingleResult<GithubUserDetail>?
    @State private var navigate = false
    var showLogin: VoidResult?
    
    var body: some View {
        if userSettings.hasLoggedIn {
            contentView()
                .padding([.top, .bottom])
                .setPrimaryBackground()
        } else {
            loginButton
        }
    }
}

extension UserListView {
    @ViewBuilder
    func contentView() -> some View {
        GHUserList(users: viewModel.userList, didTapUser: { user in
            fetchUserDetail(for: user)
        }, loadMoreFrom: { user in
            processLoadMore(currentUser: user)
        })
        .overlay(content: {
            switch viewModel.viewState {
                case .initial:
                    Color.clear
                case .loading:
                    loadingView
                case .loaded:
                   EmptyView()
                case .error(let error):
                    ErrorBanner(error: error) {
                        Task {
                            await viewModel.fetchUsers()
                        }
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding()
                }
        })
        
        .onAppear() {
            if case .initial = viewModel.viewState {
                Task {
                    await viewModel.fetchUsers()
                }
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchUsers()
            }
        }
        .onChange(of: viewModel.shouldNavigateToDetail) { oldValue, newDetail in
            if let userDetail = newDetail {
                gotoUserDetail?(userDetail)
                viewModel.shouldNavigateToDetail = nil
            }
        }
    }
    
    private var loadingView: some View {
        ZStack {
            Color.black.opacity(0.1).ignoresSafeArea()
            ProgressView("Loading...")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
    
    private var loginButton: some View {
        LoginButtonView {
            showLogin?()
        }
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
