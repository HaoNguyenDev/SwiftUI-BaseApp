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
        VStack {
            userList()
        }
        .onAppear() {
            Task {
                await viewModel.fetchUsers()
            }
        }
        .refreshable { await viewModel.fetchUsers() }
        .overlay(alignment: .bottom) {
            if viewModel.isLoading {
                loadingView
            }
            
            if let error = viewModel.error {
                ErrorBanner(error: error) {
                    Task { await viewModel.fetchUsers() }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding()
            }
        }
        .onChange(of: viewModel.userDetail) { _, newDetail in
            if let userDetail = newDetail {
                gotoUserDetail?(userDetail)
                 viewModel.userDetail = nil
            }
        }
    }
    
    private func processLoadMore(currentUser user: GithubUser) {
        Task {
            await viewModel.loadMoreUser(currentUser: user)
        }
    }
    
    @ViewBuilder
    private func userList() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.users) { user in
                    UserRowView(user: user)
                        .padding()
                        .onAppear {
                            processLoadMore(currentUser: user)
                        }
                        .onTapGesture {
                            fetchUserDetail(for: user.login)
                        }
                }
            }
        }
        .animation(.default, value: viewModel.users)
    }
    
    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .padding()
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
