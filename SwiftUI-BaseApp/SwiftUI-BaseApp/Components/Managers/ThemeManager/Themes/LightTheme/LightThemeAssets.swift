//
//  LightThemeAssets.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import SwiftUI
import RswiftResources

/// Sf mean resource name get from SF Symbol
struct LightThemeAssets: ThemeAssetsProtocol {
    var currentThemeIconSf: String { "sun.max.fill" }
    var userAvatar: UIImage { R.image.userAvatar() ?? UIImage() }
    var iconBack: UIImage { R.image.ic_back() ?? UIImage() }
    var iconClose: UIImage { R.image.ic_close() ?? UIImage() }
    var iconPhone: UIImage { R.image.ic_phone() ?? UIImage() }
    var iconEmail: UIImage { R.image.ic_email() ?? UIImage() }
    var iconPassword: UIImage { R.image.ic_password() ?? UIImage() }
    var iconGoogle: UIImage { R.image.ic_google() ?? UIImage() }
    var iconApple: UIImage { R.image.ic_apple() ?? UIImage() }
    var iconTelegram: UIImage { R.image.ic_telegram() ?? UIImage() }
}
