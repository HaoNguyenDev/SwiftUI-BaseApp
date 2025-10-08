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

// MARK: - New View State
enum GHListViewState: Equatable {
    case initial
    case loading
    case loaded([GithubUser])
    case error(Error)
    case gotoDetail(user: GithubUserDetail)
    
    static func == (lhs: GHListViewState, rhs: GHListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial), (.loading, .loading):
            return true
        case (.loaded(let lUsers), .loaded(let rUsers)):
            return lUsers.count == rUsers.count
        case (.error(let lError), .error(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        default:
            return false
        }
    }
}

// MARK: - GithubUserListVM Protocol (Cập nhật)
protocol GithubUserListVMProtocol {
    var viewState: GHListViewState { get }
    
    func fetchUsers() async
    func fetchUserDetail(username: String?) async
    func loadMoreUser(currentUser: GithubUser) async
    func updatePagination(from users: [GithubUser])
}

class GithubUserListVM: ObservableObject, GithubUserListVMProtocol {
    
    @Published private(set) var viewState: GHListViewState = .initial
    
    private let networkService: GithubServiceProtocol
    private var paginationConfig: PaginationConfig
    
    private var users: [GithubUser] {
        if case .loaded(let users) = viewState {
            return users
        }
        return []
    }
    
    init(networkService: GithubServiceProtocol = GitHubNetworkService(),
         paginationConfig: PaginationConfig = PaginationConfig(perPage: 20, since: 0)) {
        self.networkService = networkService
        self.paginationConfig = paginationConfig
    }
}

extension GithubUserListVM {
    
    @MainActor
    func fetchUsers() async {
        viewState = .loading
        
        do {
            let newUsers = try await networkService.fetchUsers(perPage: paginationConfig.perPage, since: 0)
            
            viewState = .loaded(newUsers)
            updatePagination(from: newUsers)
        } catch {
            viewState = .error(error)
        }
    }
    
    @MainActor
    func loadMoreUser(currentUser: GithubUser) async {
        guard let lastUser = users.last, currentUser.id == lastUser.id else { return }
        guard case .loaded(let currentUsers) = viewState else { return }
        
#if DEBUG
        print(">>> Load more data from user withID \(String(describing: currentUser.id))")
#endif
        do {
            let newUsers = try await networkService.fetchUsers(perPage: paginationConfig.perPage,
                                                               since: paginationConfig.since)
            let updatedUsers = currentUsers + newUsers
            viewState = .loaded(updatedUsers)
            updatePagination(from: newUsers)
        } catch {
            viewState = .error(error)
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
            return
        }
        
        do {
            let userDetail = try await networkService.fetchUserDetail(by: username)
            viewState = .gotoDetail(user: userDetail)
        } catch {
            viewState = .error(error)
        }
    }
    
}

