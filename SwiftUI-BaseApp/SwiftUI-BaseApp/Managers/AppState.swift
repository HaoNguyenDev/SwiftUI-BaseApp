//
//  AppState.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import Foundation
import Combine

actor LoadingCounter {
    var count: Int = 0
    
    func increase() {
        count += 1
    }
    
    func decrease() {
        count -= 1
        if count < 0 {
            count = 0
        }
    }
}

class AppState: ErrorHandler, ObservableObject {
    // MARK: - Loading
    @Published var isShowLoading = false
    
    @Published var isShowDrawingCoin = false
    
    /// ObservationIgnored
    private var loadingCounter = LoadingCounter()
    // MARK: - Message
    @Published var userMessageState = UserMessageState()
    
    private var allCancelAble: [AnyCancellable] = []
    
    init() {
        allCancelAble.append(userMessageState.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        })
    }
    
    @MainActor
    func showLoading() async {
        await loadingCounter.increase()
        if !isShowLoading {
            isShowLoading = true
        }
    }
    
    @MainActor
    func hideLoading() async {
        await loadingCounter.decrease()
        if await loadingCounter.count == 0 {
            isShowLoading = false
        }
    }
    
    func showToast(item: UserMessageItem) {
        userMessageState.showToast(item: item)
    }
    
    func showAlert(alertData: UserMessageItem) {
        userMessageState.showAlert(model: alertData)
    }
    
    func showInform(message: UserMessageItem, autoDissmissAfter: TimeInterval? = 3) {
        userMessageState.showInform(model: message)
    }
    
    func handleError<T>(error: T?, action: ErrorAction? = .log) {
        guard let data = self.handle(error: error) else { return }
        switch action {
        case .toast:
            showToast(item: data)
        case .alert:
            showAlert(alertData: data)
        default:
            print(data.message.orEmpty)
        }
    }
    
}
