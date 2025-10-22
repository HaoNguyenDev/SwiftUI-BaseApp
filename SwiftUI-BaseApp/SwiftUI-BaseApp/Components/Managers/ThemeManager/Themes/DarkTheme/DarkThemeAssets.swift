//
//  DarkThemeAssets.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import SwiftUI

struct DarkThemeAssets: ThemeAssetsProtocol {
    var currentThemeIcon: String { "moon.fill" }
    var userAvatar: UIImage { R.image.userAvatar() ?? UIImage() }
    var iconBack: UIImage { R.image.ic_back() ?? UIImage() }
}
