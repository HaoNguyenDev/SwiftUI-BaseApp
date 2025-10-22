//
//  UserMessageItem.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI
import Lottie

struct UserMessageItem: Equatable {
    enum DisplayType {
        case error
        case inform
        
        var color: Color {
            switch self {
            case .error:
                ThemeManager.shared.currentTheme.color.errorMessage
            case .inform:
                ThemeManager.shared.currentTheme.color.textOnSubviewColor
            }
        }
    }
    
    let icon: UIImage?
    let animation: (name: String, loop: LottieLoopMode)?
    let title: String?
    let message: String?
    let attributeMessage: AttributedString?
    let actionTitle: String?
    let type: DisplayType
    let code: AppErrorCode?
    let onClose: (() -> Void)?
    
    init(icon: UIImage? = nil,
         title: String? = nil,
         message: String? = nil,
         attributeMessage: AttributedString? = nil,
         actionTitle: String? = nil,
         displayType: DisplayType = .inform,
         code: AppErrorCode? = nil,
         onClose: (() -> Void)? = nil) {
        self.icon = icon
        self.title = title
        self.message = message
        self.animation = nil
        self.actionTitle = actionTitle
        self.type = displayType
        self.code = code
        self.attributeMessage = attributeMessage
        self.onClose = onClose
    }
    
    init(animationName: String,
         loopMode: LottieLoopMode = .loop,
         title: String? = nil,
         message: String? = nil,
         attributeMessage: AttributedString? = nil,
         actionTitle: String? = nil,
         displayType: DisplayType = .inform,
         code: AppErrorCode? = nil,
         onClose: (() -> Void)? = nil) {
        self.icon = nil
        self.title = title
        self.message = message
        self.animation = (name: animationName, loop: loopMode)
        self.actionTitle = actionTitle
        self.type = displayType
        self.code = code
        self.attributeMessage = attributeMessage
        self.onClose = onClose
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title
        && lhs.message == rhs.message
    }
}
