//
//  UserListView.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//

import SwiftUI

struct UserListView: View {
    @State private(set) var viewModel: GithubUserListVM
    var gotoUserDetail: SingleResult<Int>?
    
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
            if viewModel.isLoading {
                loadingView
            }
        }
        .task { await viewModel.fetchUsers() }
        .refreshable { await viewModel.fetchUsers() }
        .overlay(alignment: .bottom) {
            if let error = viewModel.error {
                ErrorBanner(error: error) {
                    Task { await viewModel.fetchUsers() }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding()
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
}

#Preview {
    UserListView(viewModel: GithubUserListVM(), gotoUserDetail: nil)
}
