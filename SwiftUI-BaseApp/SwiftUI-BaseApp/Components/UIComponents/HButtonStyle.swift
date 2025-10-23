//
//  HButtonStyle.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 21/10/25.
//


import SwiftUI

struct HButtonStyle: ButtonStyle {
    @Environment(\.theme) var theme
    @Environment(\.isEnabled) var isEnabled
    
    let size: ButtonSize
    let type: ButtonType
    let customTitleHorizontalPadding: CGFloat?
    let customTitleFont: Font?
    let customTitleColor: Color?
    let customBackgroundColor: Color?
    let customSelectedBackgroundColor: Color?
    
    init(size: ButtonSize,
         type: ButtonType,
         customTitleHorizontalPadding: CGFloat? = nil,
         customTitleFont: Font? = nil,
         customTitleColor: Color? = nil,
         customBackgroundColor: Color? = nil,
         customSelectedBackgroundColor: Color? = nil) {
        self.size = size
        self.type = type
        self.customTitleHorizontalPadding = customTitleHorizontalPadding
        self.customTitleFont = customTitleFont
        self.customTitleColor = customTitleColor
        self.customBackgroundColor = customBackgroundColor
        self.customSelectedBackgroundColor = customSelectedBackgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        let titleColor = titleColor(isPressed: isPressed)
        let borderColor = borderColor(isPressed: isPressed)
        let backgroundColor = backgroundColor(isPressed: isPressed)
        
        configuration.label
            .font(titleFont)
            .foregroundColor(titleColor)
            .padding(.horizontal, customTitleHorizontalPadding ?? 10)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: maxHeight)
            .background(backgroundColor.roundCorners(8))
            .fixedSize(horizontal: size != .large, vertical: size != .large)
            .roundedBorder(
                cornerRadius: 8,
                lineWidth: strokeWeight,
                borderColor: borderColor
            )
    }
}

// MARK: - Enums
extension HButtonStyle {
    enum ButtonSize {
        case large
        case medium
        case small
    }
    
    enum ButtonType {
        case primary
        case secondary
        case tertiary
    }
}

//MARK: - Getters
extension HButtonStyle {
    var strokeWeight: CGFloat { type == .secondary || type == .tertiary ? 1 : 0 }
    var maxWidth: CGFloat? { size == .large ? .infinity : nil }
    var minHeight: CGFloat? { size == .small ? 0 : 44 }
    var maxHeight: CGFloat? { size == .large ? 56 : 44 }
    
    func backgroundColor(isPressed: Bool) -> Color {
        
        /// case button disabled
        guard isEnabled else {
            if let customBackgroundColor {
                if let customSelectedBackgroundColor {
                    return isPressed ? customSelectedBackgroundColor : customBackgroundColor
                }
                return customBackgroundColor.opacity(0.5)
            }
            
            switch type {
            case .primary:
                return theme.color.buttonPrimaryDisabledBg
            case .secondary:
                return theme.color.buttonSecondaryDisabledBg
            case .tertiary:
                return theme.color.buttonTertiaryDisabledBg
            }
        }
        
        if let customBackgroundColor {
            if let customSelectedBackgroundColor {
                return isPressed ? customSelectedBackgroundColor : customBackgroundColor
            }
            return customBackgroundColor
        }
        
        switch type {
        case .primary:
            return isPressed ? theme.color.buttonPrimarySelectedBg : theme.color.buttonPrimaryBg
        case .secondary:
            return isPressed ? theme.color.buttonSecondarySelectedBg : theme.color.buttonSecondaryBg
        case .tertiary:
            return isPressed ? theme.color.buttonTertiarySelectedBg : theme.color.buttonTertiaryBg
        }
    }
    
    var titleFont: Font {
        if let customTitleFont { return customTitleFont }
        return theme.font.semibold(ofSize: TextSize.body)
    }
    
    func titleColor(isPressed: Bool) -> Color {
        /// case button disabled
        guard isEnabled else {
            if let customTitleColor {
                return customTitleColor.opacity(0.5)
            }
            return theme.color.buttonPrimaryTitle.opacity(0.5)
        }
        
        if let customTitleColor { return customTitleColor }
        
        switch type {
        case .primary:
            return isEnabled ? theme.color.buttonPrimaryTitle : theme.color.buttonPrimaryTitle.opacity(0.5)
        case .secondary:
            return isEnabled ? theme.color.buttonSecondaryTitle :  theme.color.buttonSecondaryTitle.opacity(0.5)
        case .tertiary:
            return isEnabled ? theme.color.buttonTertiaryTitle : theme.color.buttonTertiaryTitle.opacity(0.5)
        }
    }
    
    func borderColor(isPressed: Bool) -> Color {
        if let customTitleColor {
            return customTitleColor
        }
        
        guard isEnabled else {
            switch type {
            case .primary:
                return Color.clear
            case .secondary:
                return Color.clear
            case .tertiary:
                return theme.color.buttonPrimaryTitle.opacity(0.5)
            }
        }
        
        switch type {
        case .primary:
            return theme.color.buttonPrimaryBoder
        case .secondary:
            return theme.color.buttonSecondaryBoder
        case .tertiary:
            return theme.color.buttonTertiaryBoder
        }
    }
}

// MARK: - ButtonStyle
extension ButtonStyle where Self == HButtonStyle {
    static var primaryHButton: HButtonStyle {
        HButtonStyle(size: .large, type: .primary)
    }
    static func primaryHButtonStyle(size: HButtonStyle.ButtonSize,
                                    titlePadding: CGFloat? = nil,
                                    titleFont:Font? = nil,
                                    titleColor: Color? = nil,
                                    backgroundColor: Color? = nil,
                                    selectedBackgroundColor: Color? = nil) -> HButtonStyle {
        HButtonStyle(size: size,
                     type: .primary,
                     customTitleHorizontalPadding: titlePadding,
                     customTitleFont: titleFont,
                     customTitleColor: titleColor,
                     customBackgroundColor: backgroundColor,
                     customSelectedBackgroundColor: selectedBackgroundColor)
    }
    
    static var secondaryHButton: HButtonStyle {
        HButtonStyle(size: .large, type: .secondary)
    }
    static func secondaryHButtonStyle(size: HButtonStyle.ButtonSize,
                                      titlePadding: CGFloat? = nil,
                                      titleFont:Font? = nil,
                                      titleColor: Color? = nil,
                                      backgroundColor: Color? = nil,
                                      selectedBackgroundColor: Color? = nil) -> HButtonStyle {
        HButtonStyle(size: size,
                     type: .secondary,
                     customTitleHorizontalPadding: titlePadding,
                     customTitleFont: titleFont,
                     customTitleColor: titleColor,
                     customBackgroundColor: backgroundColor,
                     customSelectedBackgroundColor: selectedBackgroundColor)
    }
    
    static var tertiaryHButton: HButtonStyle {
        HButtonStyle(size: .large, type: .tertiary)
    }
    static func tertiaryHButtonStyle(size: HButtonStyle.ButtonSize,
                                     titlePadding: CGFloat? = nil,
                                     titleFont:Font? = nil,
                                     titleColor: Color? = nil,
                                     backgroundColor: Color? = nil,
                                     selectedBackgroundColor: Color? = nil) -> HButtonStyle {
        HButtonStyle(size: size,
                     type: .tertiary,
                     customTitleHorizontalPadding: titlePadding,
                     customTitleFont: titleFont,
                     customTitleColor: titleColor,
                     customBackgroundColor: backgroundColor,
                     customSelectedBackgroundColor: selectedBackgroundColor)
    }
}

#Preview("Style=Primary") {
    @Previewable @Environment(\.theme) var theme: any ThemeProtocol
    VStack(spacing: 20) {
        Button("Large") {}
            .buttonStyle(.primaryHButtonStyle(size: .large, backgroundColor: nil))
        
        Button("Large") {}
            .buttonStyle(.primaryHButtonStyle(size: .large, backgroundColor: nil))
            .disabled(true)
        
        Button("Medium") {}
            .buttonStyle(.primaryHButtonStyle(size: .medium, backgroundColor: nil))
        
        Button("Medium") {}
            .buttonStyle(.primaryHButtonStyle(size: .medium, backgroundColor: nil))
            .disabled(true)
        
        Button("Small") {}
            .buttonStyle(.primaryHButtonStyle(size: .small, backgroundColor: nil))
        
        Button("Small") {}
            .buttonStyle(.primaryHButtonStyle(size: .small, backgroundColor: nil))
            .disabled(true)
    }
    .padding()
    .environmentTheme(manager: ThemeManager.shared)
}

#Preview("Style=Secondary") {
    @Previewable @Environment(\.theme) var theme: any ThemeProtocol
    VStack(spacing: 20) {
        Button("Large") {}
            .buttonStyle(.secondaryHButtonStyle(size: .large))
        
        Button("Large") {}
            .buttonStyle(.secondaryHButtonStyle(size: .large))
            .disabled(true)
        
        Button("Medium") {}
            .buttonStyle(.secondaryHButtonStyle(size: .medium))
        
        Button("Medium") {}
            .buttonStyle(.secondaryHButtonStyle(size: .medium))
            .disabled(true)
        
        Button("Small") {}
            .buttonStyle(.secondaryHButtonStyle(size: .small))
        
        Button("Small") {}
            .buttonStyle(.secondaryHButtonStyle(size: .small))
            .disabled(true)
    }
    .padding()
    .environmentTheme(manager: ThemeManager.shared)
}

#Preview("Style=Tertiary") {
    @Previewable @Environment(\.theme) var theme: any ThemeProtocol
    VStack(spacing: 20) {
        Button("Large") {}
            .buttonStyle(.tertiaryHButtonStyle(size: .large))
        
        Button("Large") {}
            .buttonStyle(.tertiaryHButtonStyle(size: .large))
            .disabled(true)
        
        Button("Medium") {}
            .buttonStyle(.tertiaryHButtonStyle(size: .medium))
        
        Button("Medium") {}
            .buttonStyle(.tertiaryHButtonStyle(size: .medium))
            .disabled(true)
        
        Button("Small") {}
            .buttonStyle(.tertiaryHButtonStyle(size: .small))
        
        Button("Small") {}
            .buttonStyle(.tertiaryHButtonStyle(size: .small))
            .disabled(true)
    }
    .padding()
    .environmentTheme(manager: ThemeManager.shared)
}

#Preview("Custom Buttons") {
    @Previewable @Environment(\.theme) var theme
    VStack(spacing: 20) {
        
        
        Button("Primary") {}
            .buttonStyle(.primaryHButtonStyle(size: .medium,
                                              titlePadding: 20,
                                              titleFont: theme.font.regular(ofSize: TextSize.buttonTitle1),
                                              titleColor: Color.white,
                                              backgroundColor: Color.green,
                                              selectedBackgroundColor: Color.green.opacity(0.5)))
        
        Button("Secondary") {}
            .buttonStyle(.secondaryHButtonStyle(size: .medium))
        
        Button("Tertiary") {}
            .buttonStyle(.tertiaryHButtonStyle(size: .medium, titleColor: Color.blue))
    }
    .padding(.horizontal, 50)
    .environmentTheme(manager: ThemeManager.shared)
}
