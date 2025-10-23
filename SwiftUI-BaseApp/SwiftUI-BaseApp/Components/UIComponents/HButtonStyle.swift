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
        let fillColor = fillColor(isPressed: isPressed)
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
                borderColor: fillColor
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
    var strokeWeight: CGFloat { type == .secondary ? 1 : 0 }
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
                return theme.color.buttonPrimaryDisabledBg
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
            return isPressed ? theme.color.buttonPrimarySelectedBg : theme.color.buttonPrimaryBg
        }
    }
    
    var titleFont: Font {
        if let customTitleFont { return customTitleFont }
        return theme.font.bold(ofSize: 16)
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
            return isEnabled ? theme.color.buttonPrimaryTitle : theme.color.buttonPrimaryTitle.opacity(0.5)
        }
    }
    
    func fillColor(isPressed: Bool) -> Color {
        if let customTitleColor {
            return customTitleColor
        }
        
        guard isEnabled else {
            switch type {
            case .primary:
                return theme.color.buttonPrimaryTitle.opacity(0.5)
            case .secondary:
                return theme.color.buttonSecondaryTitle.opacity(0.5)
            case .tertiary:
                return theme.color.buttonPrimaryTitle.opacity(0.5)
            }
        }
        
        switch type {
        case .primary:
            return theme.color.buttonPrimaryTitle
        case .secondary:
            return theme.color.buttonSecondaryTitle
        case .tertiary:
            return theme.color.buttonPrimaryTitle
        }
    }
}

// MARK: - ButtonStyle
extension ButtonStyle where Self == HButtonStyle {
    static func primaryHButtonStyle(size: HButtonStyle.ButtonSize,
                        titleColor: Color? = nil,
                        titlePadding: CGFloat? = nil,
                        customTitleFont:Font? = nil,
                        customTitleColor:Color? = nil,
                        backgroundColor: Color? = nil) -> HButtonStyle {
        HButtonStyle(size: size,
                     type: .primary,
                     customTitleHorizontalPadding: titlePadding,
                     customTitleFont: customTitleFont,
                     customTitleColor: customTitleColor,
                     customBackgroundColor: backgroundColor)
    }
    
    static func secondaryHButtonStyle(size: HButtonStyle.ButtonSize,
                          titleColor: Color? = nil,
                          titlePadding: CGFloat? = nil,
                          customTitleFont:Font? = nil,
                          customTitleColor:Color? = nil,
                          backgroundColor: Color? = nil) -> HButtonStyle {
          HButtonStyle(size: size,
                       type: .secondary,
                       customTitleHorizontalPadding: titlePadding,
                       customTitleFont: customTitleFont,
                       customTitleColor: customTitleColor,
                       customBackgroundColor: backgroundColor)
    }
    
    static func tertiaryHButtonStyle(size: HButtonStyle.ButtonSize,
                          titleColor: Color? = nil,
                          titlePadding: CGFloat? = nil,
                          customTitleFont:Font? = nil,
                          customTitleColor:Color? = nil,
                          backgroundColor: Color? = nil) -> HButtonStyle {
          HButtonStyle(size: size,
                       type: .secondary,
                       customTitleHorizontalPadding: titlePadding,
                       customTitleFont: customTitleFont,
                       customTitleColor: customTitleColor,
                       customBackgroundColor: backgroundColor)
    }
    
    static var tertiaryHButton: HButtonStyle {
        HButtonStyle(size: .large, type: .tertiary)
    }
    
    static func tertiary(size: HButtonStyle.ButtonSize) -> HButtonStyle {
        HButtonStyle(size: size, type: .tertiary)
    }
}

#Preview("Style=Primary") {
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
}

#Preview("Style=Secondary") {
    VStack(spacing: 20) {
        Button("Large") {}
            .buttonStyle(.secondaryHButtonStyle(size: .large, backgroundColor: nil))
        
        Button("Large") {}
            .buttonStyle(.secondaryHButtonStyle(size: .large, backgroundColor: nil))
            .disabled(true)
        
        Button("Medium") {}
            .buttonStyle(.secondaryHButtonStyle(size: .medium, backgroundColor: nil))
        
        Button("Medium") {}
            .buttonStyle(.secondaryHButtonStyle(size: .medium, backgroundColor: nil))
            .disabled(true)
        
        Button("Small") {}
            .buttonStyle(.secondaryHButtonStyle(size: .small, backgroundColor: nil))
        
        Button("Small") {}
            .buttonStyle(.secondaryHButtonStyle(size: .small, backgroundColor: nil))
            .disabled(true)
    }
    .padding()
}

#Preview("Style=Tertiary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(.tertiaryHButton)
        
        Button("Continue") {}
            .buttonStyle(.tertiaryHButton)
            .disabled(true)
    }
    .padding()
}

#Preview("Custom Buttons") {
    @Previewable @Environment(\.theme) var theme
    VStack(spacing: 20) {
        Button("Primary-Large") {}
            .buttonStyle(
                HButtonStyle(
                    size: .large,
                    type: .primary
                )
            )
        
        Button("Primary-Large-Medium") {}
            .buttonStyle(
                HButtonStyle(
                    size: .medium,
                    type: .primary
                )
            )
            .disabled(false)
        
        Button("Primary-Large-CustomColor") {}
            .buttonStyle(
                HButtonStyle(
                    size: .large,
                    type: .primary,
                    customTitleColor: theme.color.buttonSecondaryTitle,
                    customBackgroundColor: theme.color.buttonSecondaryBg,
                    customSelectedBackgroundColor: theme.color.buttonSecondarySelectedBg
                )
            )
            .disabled(false)
        
        Button("Secondary-Large") {}
            .buttonStyle(
                HButtonStyle(
                    size: .large,
                    type: .secondary
                )
            )
        
        Button("Secondary-Medium") {}
            .buttonStyle(
                HButtonStyle(
                    size: .medium,
                    type: .secondary
                )
            )
    }
    .padding()
}
