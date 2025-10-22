//
//  GithubService.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 31/8/25.
//

import Foundation

// MARK: - GithubServiceProtocol
protocol GithubServiceProtocol {
    func fetchUsers(perPage: Int, since: Int) async throws -> [GithubUser]
    func fetchUserDetail(by username: String) async throws -> GithubUserDetail
}

// MARK: - GithubNetworkService
class GithubNetworkService: GithubServiceProtocol {
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GithubUser] {
        let endpoint = GithubAPIEndpoint.getUsersEndpoint(perPage: perPage, since: since)
        return try await networkManager.requestAsync(endpoint: endpoint)
    }
    
    func fetchUserDetail(by username: String) async throws -> GithubUserDetail {
        let endpoint = GithubAPIEndpoint.getUserDetailEndpoint(username: username)
        return try await networkManager.requestAsync(endpoint: endpoint)
    }
}
