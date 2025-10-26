//
//  ViewStateable.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 25/10/25.
//


protocol ViewStateable {
    associatedtype ViewState
    var viewState: ViewState { get set }
    func changeState(_ newState: ViewState)
}
