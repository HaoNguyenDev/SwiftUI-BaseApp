//
//  HTextField.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 24/10/25.
//


import SwiftUI

struct HTextField: View {
    @Environment(\.theme) var theme: any ThemeProtocol
    @Environment(\.isEnabled) var isEnabled
    @FocusState private var isFocused
    
    let title: String?
    let placeholder: String
    let keyboardType: UIKeyboardType
    let leftImage: UIImage?
    @Binding var text: String
    @Binding var errorMessage: String?
    var onTap: VoidResult? = nil
    
    init(title: String?,
         placeholder: String,
         keyboardType: UIKeyboardType = .default,
         leftImage: UIImage? = nil,
         text: Binding<String>,
         errorMessage: Binding<String?> = .constant(nil),
         onTap: VoidResult? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.leftImage = leftImage
        self._text = text
        self._errorMessage = errorMessage
        self.onTap = onTap
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleText()
            textField()
            errorText()
                .padding(.top, 4)
        }
        .onTapGesture {
            isFocused = true
            onTap?()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

fileprivate extension HTextField {
    
    @ViewBuilder
    private func titleText() -> some View {
        if let title = title {
            Text(title)
                .font(titleFont)
                .foregroundColor(foregroundColor)
                .padding(.bottom, 8)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func textField() -> some View {
        HStack(spacing: 8) {
            leftImageView()
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(theme.font.regular(ofSize: 14))
                        .foregroundStyle(theme.color.secondaryText)
                        .multilineTextAlignment(.leading)
                }
                
                TextField("", text: $text)
                    .foregroundColor(isEnabled ? theme.color.primaryText : theme.color.secondaryText)
                    .focused($isFocused)
                    .font(theme.font.regular(ofSize: 14))
                    .frame(maxHeight: isFocused || !text.isEmpty ? .infinity : 0)
                    .tint(theme.color.secondaryText)
                    .keyboardType(keyboardType)
            }
            clearTextButton()
        }
        .padding(.leading, PaddingSize.standard)
        .padding(.trailing, .zero)
        .frame(maxWidth: .infinity, minHeight: HeightSize.dfTextField, maxHeight: HeightSize.dfTextField, alignment: .leading)
        .background(theme.color.secondaryBg)
        .roundedBorder(cornerRadius: RadiusSize.textField, lineWidth: 1, borderColor: borderColor)
        .roundCorners(RadiusSize.textField)
    }
    
    @ViewBuilder
    func errorText() -> some View {
        if let errorMessage {
            Text(errorMessage)
                .font(theme.font.regular(ofSize: 14))
                .foregroundStyle(theme.color.errorMessage)
        }
    }
    
    @ViewBuilder
    func leftImageView() -> some View {
        if let leftImage {
            let image = leftImage.withRenderingMode(.alwaysTemplate)
            Image(uiImage: image)
                .iconStyle(
                    width: 35,
                    height: 35,
                    mode: .fit
                )
                .foregroundColor(theme.color.secondaryText)
        }
    }
    
    @ViewBuilder
    func clearTextButton() -> some View {
        if !text.isEmpty {
            Button(action: {
                text = ""
                isFocused = false
            }) {
                let image = theme.assets.iconClose.withRenderingMode(.alwaysTemplate)
                Image(uiImage: image)
                    .iconStyle(
                        width: 35,
                        height: 35,
                        mode: .fit
                    )
                    .foregroundStyle(theme.color.secondaryText)
                    .padding(PaddingSize.medium)
            }
        }
    }
}

fileprivate extension HTextField {
    var borderColor: Color {
        guard errorMessage == nil else { return theme.color.errorMessage }
        return isFocused
        ? theme.color.secondaryText
        : theme.color.secondaryBg
    }
    
    var foregroundColor: Color {
        if !isEnabled { return theme.color.secondaryText }
        return isFocused ? theme.color.secondaryText : theme.color.secondaryText
    }
    
    var titleFont: Font {
        if !isEnabled { return theme.font.regular(ofSize: TextSize.subhead)}
        return isFocused ? theme.font.semibold(ofSize: TextSize.subhead) : theme.font.regular(ofSize: TextSize.subhead)
    }
}

struct HTextField_Previews : View {
    @Environment(\.theme) var theme
    @State var text: String = ""
    @State var phoneNumber: String = "0977 123 456"
    @State var email: String = "example@example.com"
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                HTextField(title: "Default",
                           placeholder: "Enter your text",
                           leftImage: nil,
                           text: $text)
                
                HTextField(title: "Error",
                           placeholder: "Enter your text",
                           leftImage: nil,
                           text: $text,
                           errorMessage: .constant("Error message appears here"))
                
                HTextField(title: "Phone Field",
                           placeholder: "Enter your phone number",
                           keyboardType: .phonePad,
                           leftImage: theme.assets.iconPhone,
                           text: $phoneNumber,
                           errorMessage: .constant(nil))
                
                
                HTextField(title: "Email Field",
                           placeholder: "Enter your phone number",
                           keyboardType: .emailAddress,
                           leftImage: theme.assets.iconEmail,
                           text: $email,
                           errorMessage: .constant(nil))
                
                HTextField(title: "Disable Field",
                           placeholder: "Enter something...",
                           keyboardType: .default,
                           text: .constant(""),
                           errorMessage: .constant(nil))
                .disabled(true)
            }
        }
        .padding()
    }
}

#Preview {
    HTextField_Previews()
        .environmentTheme(manager: ThemeManager.shared)
        .setPrimaryBackground()
    
}
