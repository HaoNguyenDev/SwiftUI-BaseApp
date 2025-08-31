//
//  GithubUserListVM.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//


import SwiftUI

// MARK: - Support for Loadmore
struct PaginationConfig {
    var perPage: Int
    var since: Int
}

// MARK: - UserListViewModel Protocol
protocol GithubUserListVMProtocol {
    var users: [GithubUser] { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    func fetchUsers() async
    func fetchUserDetail(username: String?) async
    func loadMoreUser(currentUser: GithubUser) async
    func updatePagination(from users: [GithubUser])
}

class GithubUserListVM: ObservableObject, GithubUserListVMProtocol {
    @Published private(set) var users: [GithubUser] = []
    @Published private(set) var userDetail: GithubUserDetail?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    private let networkService: GithubServiceProtocol
    private var paginationConfig: PaginationConfig
    
    init(networkService: GithubServiceProtocol = GitHubNetworkService(),
         paginationConfig: PaginationConfig = PaginationConfig(perPage: 20, since: 0)) {
        self.networkService = networkService
        self.paginationConfig = paginationConfig
    }
}

extension GithubUserListVM {
    @MainActor
    func fetchUsers() async {
        await performWithLoading {
            do {
                var newUsers: [GithubUser] = []
                newUsers = try await networkService.fetchUsers(perPage: paginationConfig.perPage,
                                                               since: 0)
                await updateUsers(newUsers)
                updatePagination(from: newUsers)
            } catch {
                self.error = error
            }
        }
    }
    
    @MainActor
    func loadMoreUser(currentUser: GithubUser) async {
        guard let lastUser = users.last, currentUser == lastUser,
              !isLoading,
              !users.isEmpty else { return }
#if DEBUG
        print(">>> Load more data from user withID \(String(describing: currentUser.id))")
#endif
        await performWithLoading {
            do {
                let newUsers = try await networkService.fetchUsers(perPage: paginationConfig.perPage,
                                                                   since: paginationConfig.since)
                await appendUsers(newUsers)
                updatePagination(from: newUsers)
            } catch {
                self.error = error
            }
        }
    }
    
    func updatePagination(from users: [GithubUser]) {
        if let lastUserId = users.last?.id {
            paginationConfig.since = lastUserId
        }
    }
    
    @MainActor
    func fetchUserDetail(username: String?) async {
        guard let username = username, !username.isEmpty else {
            self.error = NSError(domain: "Invalid username", code: 1001, userInfo: nil)
            return
        }
        
        await performWithLoading {
            do {
                let userDetail = try await networkService.fetchUserDetail(by: username)
                self.userDetail = userDetail
                // TODO: gán userDetail vào @Published property nếu cần
            } catch {
                self.error = error
            }
        }
    }
    
}

// MARK: - Private Helper Methods
extension GithubUserListVM {
    @MainActor
    private func performWithLoading(_ operation: () async throws -> Void) async {
        guard !isLoading else { return }
        isLoading = true
        error = nil
        defer { isLoading = false }
        do {
            try await operation()
        } catch {
            self.error = error
        }
    }
    
    private func updateUsers(_ newUsers: [GithubUser]) async {
        await MainActor.run { [weak self] in
            self?.users = newUsers
        }
    }
    
    private func appendUsers(_ newUsers: [GithubUser]) async {
        await MainActor.run { [weak self] in
            self?.users.append(contentsOf: newUsers)
        }
    }
}
