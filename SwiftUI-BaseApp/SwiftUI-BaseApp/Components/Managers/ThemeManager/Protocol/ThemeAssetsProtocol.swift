//
//  ThemeAssetsProtocol.swift
//  t5x-ios
//

import SwiftUI

/// Sf mean resource name get from SF Symbol
protocol ThemeAssetsProtocol {
    var currentThemeIconSf: String { get }
    var userAvatar: UIImage { get }
    var iconBack: UIImage { get }
    var iconClose: UIImage { get }
    var iconPhone: UIImage { get }
    var iconEmail: UIImage { get }
    var iconPassword: UIImage { get }
    var iconGoogle: UIImage { get }
    var iconApple: UIImage { get }
    var iconTelegram: UIImage { get }
}
