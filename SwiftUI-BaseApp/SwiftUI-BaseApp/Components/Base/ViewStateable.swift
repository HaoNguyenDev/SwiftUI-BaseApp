//
//  ViewStateable.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 25/10/25.
//


protocol ViewStateable {
    associatedtype ViewState
    func changeState(_ newState: ViewState)
}