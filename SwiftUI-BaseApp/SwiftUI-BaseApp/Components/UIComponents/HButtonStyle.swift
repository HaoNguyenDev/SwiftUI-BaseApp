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
    static var primaryHButton: HButtonStyle {
        HButtonStyle(size: .large, type: .primary)
    }
    
    static func primary(size: HButtonStyle.ButtonSize) -> HButtonStyle {
        HButtonStyle(size: size, type: .primary)
    }
    
    static func primary(color: Color? = nil) -> HButtonStyle {
        HButtonStyle(size: .large, type: .primary, customBackgroundColor: color)
    }
    
    static var secondaryHButton: HButtonStyle {
        HButtonStyle(size: .large, type: .secondary)
    }
    
    static func secondary(color: Color? = nil) -> HButtonStyle {
        HButtonStyle(size: .large, type: .secondary, customTitleColor: color)
    }
    
    static func secondary(size: HButtonStyle.ButtonSize) -> HButtonStyle {
        HButtonStyle(size: size, type: .secondary)
    }
    
    static var tertiaryHButton: HButtonStyle {
        HButtonStyle(size: .large, type: .tertiary)
    }
    
    static func tertiary(size: HButtonStyle.ButtonSize) -> HButtonStyle {
        HButtonStyle(size: size, type: .tertiary)
    }
}

#Preview("Size=Large, Style=Primary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(.primaryHButton)
        
        Button("Continue") {}
            .buttonStyle(.primaryHButton)
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Large, Style=Secondary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(.secondaryHButton)
        
        Button("Continue") {}
            .buttonStyle(.secondaryHButton)
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Large, Style=Tertiary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(.tertiaryHButton)
        
        Button("Continue") {}
            .buttonStyle(.tertiaryHButton)
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Medium, Style=Primary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .medium, type: .primary))
        
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .medium, type: .primary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Medium, Style=Secondary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .medium, type: .secondary))
        
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .medium, type: .secondary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Medium, Style=Tertiary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .medium, type: .tertiary))
        
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .medium, type: .tertiary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Small, Style=Primary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .small, type: .primary))
        
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .small, type: .primary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Small, Style=Secondary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .small, type: .secondary))
        
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .small, type: .secondary))
            .disabled(true)
    }
    .padding()
}

#Preview("Size=Small, Style=Tertiary") {
    VStack(spacing: 20) {
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .small, type: .tertiary))
        
        Button("Continue") {}
            .buttonStyle(HButtonStyle(size: .small, type: .tertiary))
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
