//
//  LightThemeAssets.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import SwiftUI
import RswiftResources

struct LightThemeAssets: ThemeAssetsProtocol {
    var userAvatar: UIImage { R.image.manUserCircleIcon() ?? UIImage() }
    var iconBack: UIImage { R.image.ic_back() ?? UIImage() }
}
