//
//  AccountViewModel.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 21/10/25.
//

import SwiftUI

// MARK: - New View State
enum AccountViewState {
    case initial
    case loading
    case loaded
}

// MARK: - AccountViewModelProtocol
protocol AccountViewModelProtocol {
    var viewState: AccountViewState { get }
    func loading(show: Bool)
}

// MARK: AccountViewModel
@Observable class AccountViewModel: AccountViewModelProtocol {
    var viewState: AccountViewState
    
    init() {
        self.viewState = .loaded
    }
    
    func loading(show: Bool) {
        viewState = show ? .loading : .loaded
    }
}
