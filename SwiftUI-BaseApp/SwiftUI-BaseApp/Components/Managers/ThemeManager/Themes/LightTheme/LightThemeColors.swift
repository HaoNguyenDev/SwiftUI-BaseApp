//
//  LightThemeColors.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import UIKit
import SwiftUI

struct LightThemeColors: ThemeColorProtocol {
    let backgroundView: Color = R.color.backgroundView.color
    let bgColor = Color(hex: "#ffffff")
    let subviewBgColor = Color(hex: "#333333")
    var textOnSubviewColor = Color(hex: "#ffffff")
    let gradientBgColors = [Color(hex: "#ffffff"), Color(hex: "#4C4CFF")]
    let textColor = Color(hex: "#333333")
    let buttonBgColor = Color(hex: "#007AFF")
    let mainTabSelectedTextColor = Color(hex: "#ffffff")
    let mainTabUnselectedTextColor =  Color(hex: "#AEAEB2")
    
    // Primary
    let primariesDefault: Color = R.color.primariesDefault.color
    let primariesShade1: Color = R.color.primariesShade1.color
    let primariesShade2: Color = R.color.primariesShade2.color
    let primariesShade3: Color = R.color.primariesShade3.color
    var primariesSelected: Color = R.color.primariesSelected.color
    var primary: Color = Color(hex: "#222222")
    var brandColor: Color = R.color.primariesDefault.color
    
    // Text
    let textPrimary: Color = R.color.textPrimary.color
    let textSecondary: Color = R.color.textSecondary.color
    let textTertiary: Color = R.color.textTertiary.color
    let textDisabled: Color = R.color.textDisabled.color
    let textWhite: Color = R.color.textWhite.color
    let textOverImage: Color = R.color.textWhite.color
    
    // Semantics
    let semanticsSuccessFull: Color = R.color.semanticsSuccessFull.color
    var semanticsSuccessSelected: Color = R.color.semanticsSuccessSelected.color
    let semanticsWarnFull: Color = R.color.semanticsWarnFull.color
    let semanticsInfoFull: Color = R.color.semanticsInfoFull.color
    let semanticsInfoSecondary: Color = R.color.semanticsInfoSecondary.color
    let semanticsErrorFull: Color = R.color.semanticsErrorFull.color
    var semanticsErrorSelected: Color = R.color.semanticsErrorSelected.color
    
    // Neutrals
    let neutralsBackgroundPrimary: Color = R.color.neutralsBackgroundPrimary.color
    let neutralsBackgroundSecondary: Color = R.color.neutralsBackgroundSecondary.color
    let neutralsCards: Color = R.color.neutralsCards.color
    let neutralsFieldsTags: Color = R.color.neutralsFieldsTags.color
    let neutralsBorderDivider: Color = R.color.neutralsBorderDivider.color
    let neutralsButtonDisabled: Color = R.color.neutralsButtonDisabled.color
    
    let backgroundLight: Color = R.color.backgroundLight.color
    var backgroundDark: Color = R.color.backgroundDark.color
    let backgroundTertiary: Color = R.color.backgroundTetiary.color
    let lineGrey: Color = Color(hex: "#E0E0E0")
    let backgroundNew: Color = Color(hex: "#F83C00")
    var tabbarLoading: Color = R.color.gray_EDEDED.color
    var brandColor2Positive: Color = R.color.brandColor2Positive.color
    var errorMessage: Color = R.color.errorMessage.color
    var registerTextColor: Color = Color(hex: "#F83C00")
    var registerLineGrey: Color = Color(hex: "#999999")
    var registerBgColor: Color = Color(hex: "#EBEBEB")
    var segmentUnselectColor: Color = Color(hex: "#CCCCCC")
    var segmentSelectedColor: Color = Color(hex: "#FFFFFF")
    var segmentTextColor: Color = Color(hex: "#222222")
    var loginErrorTextColor: Color = Color(hex: "#FF262E")
    var loginBtnColor: Color = Color(hex: "#00C036")
    var graniteGray: Color = Color(hex: "#666666")
    
    var segmentDefaultBackground: Color = Color(hex: "#D9D9D9")
    var segmentDefaultSelectedBackground: Color = Color(hex: "#FFFFFF")
    var segmentDefaultSelectedText: Color = Color(hex: "#000000")
    var segmentDefaultUnSelectedText: Color = Color(hex: "#666666")
    
    var statusBarStyle: UIStatusBarStyle { .lightContent }

    var buttonPrimaryBg: Color = Color(hex: "#F83C00")
    var buttonSecondaryBg: Color { .clear }
    var buttonTertiaryBg: Color { .clear }
    var buttonCommonBg: Color = Color(hex: "#FFFFFF")
    var buttonPositiveBg: Color = Color(hex: "#00C036")
    var buttonNegativeBg: Color = Color(hex: "#FF262E")
    var buttonCommonText: Color = Color(hex: "#222222")
    var buttonBrandText: Color = Color(hex: "#F83C00")
    var buttonActiveText: Color = Color(hex: "#FFFFFF")
    var buttonDisableBg: Color = Color(hex: "#E0E0E0")
    var buttonDisableText: Color = Color(hex: "#999999")
    var buttonDisableBorder: Color = Color(hex: "#E0E0E0")
    var buttonPrimaryBorder: Color = Color(hex: "#E03800")
    var textfieldFocusFilledBorder: Color = Color(hex: "#33C85D")
    var textfieldFocusFailedBorder: Color = Color(hex: "#FF262E")
    var textfieldActiveBg: Color = Color(hex: "#FFFFFF")
    var textfieldDisableBg: Color = Color(hex: "#E0E0E0")
    var textBrand: Color = Color(hex: "#F83C00")
    var textPositive: Color = Color(hex: "#00C036")
    var textNegative: Color = Color(hex: "#F01616")
    var navigationBg: Color = Color(hex: "#000000")
    var backgroundPrimary: Color = Color(hex: "#EBEBEB")
    var eventHeaderTitle: Color = Color(hex: "#222222")
    var gray_BEBEBE: Color = Color(hex: "#BEBEBE")
    var bgTertiary: Color = Color(hex: "#F2F2F2")
    var tertiary: Color = Color(hex: "#999999")
    var primaryLight: Color = Color(hex: "#FFF1ED")
    var secondary: Color = Color(hex: "#666666")
    var lightGray: Color = Color(hex: "#E0E0E0")
    var divider: Color = Color(hex: "#E6E6E6")
    var gainsboro: Color = Color(hex: "#DDDDDD")
    var errorAndImportant: Color = Color(hex: "#F01616")
    var philippineSilver: Color = Color(hex: "#B1B1B3")
    var disclaimerBackground: Color = Color(hex: "#FFF5BF")
    var darkYellow: Color = Color(hex: "#998200")
    var backgroundSecondary: Color = Color(hex: "#FFFFFF")
    var lightGreen: Color = Color(hex: "#1FD1A1")
    var whiteColor: Color = Color(hex: "#FFFFFF")
    var red: Color = Color(hex: "#F01F1F")
    var cultured: Color = Color(hex: "#F5F5F5")
    var blackColor: Color = Color(hex: "#000000")
    var redLoseBackground: Color = Color(hex: "#FFDEDE")
    var greenWinBackground: Color = Color(hex: "#DDFFE5")
    var greyBackgroundButton: Color = Color(hex: "#F2F2F2")
    var jetColor: Color = Color(hex: "#363636")
    var backgroundStatus: Color = Color(hex: "#E6EFFF")
    var lightBlue: Color = Color(hex: "#0058C0")
    var backgoundCalendarSelect: Color = Color(hex: "#FFF1ED")
    var lightOrange_FF8955: Color = Color(hex: "#FF8955")
    var coralRed_F53D3D: Color = Color(hex: "#F53D3D")
    var green2Positive: Color = Color(hex: "#00C036")
    var silver: Color = Color(hex: "#CCCCCC")
    var greyDefaultBankCard: Color = Color(hex: "#FFE8F9")
    var lightCultured: Color = Color(hex: "#F4F4F4")
    var pendingBackgroundStatus: Color = Color(hex: "#E6EFFF")
    var successTextColor: Color = Color(hex: "#14C36B")
    var withdrawingTextColor: Color = Color(hex: "#4AA4FF")
    var withdrawingBackgroundColor: Color = Color(hex: "#DDF7FF")
    var failedBackgroundColor: Color = Color(hex: "#FFDDDD")
    var lightVioletColor: Color = Color(hex: "#8C4EFF")
    var mediumVioletColor: Color = Color(hex: "#6B3FFC")
    var white30OpacityColor: Color = Color(hex: "#FFFFFF").opacity(0.3)
    var linenColor: Color = Color(hex: "#FFEDE6")
    var errorAndImportant2: Color = Color(hex: "#FF262E")
    var colorOrange: Color = Color(hex: "#FD6B3C")
    var razzmatazzColor: Color = Color(hex: "#F42766")
    var textColorPopupLogin: Color = Color(hex: "#F83C00")
    var accountHeaderBgColor: Color = Color(hex: "#FD6B3C")
    var skeletonHeaderBgColor: Color = Color(hex: "#222222")
    var userProfileHeaderBgColor:  Color = Color(hex: "#FD6B3C")
    var rhythm: Color = Color(hex: "#6F7AA4")
    var lavenderGray: Color = Color(hex: "#C0C5D7")
    var greenBold: Color = Color(hex: "#00CE3A")
    var darkGray: Color = Color(hex: "#262B33")
    var textGray: Color = Color(hex: "#999999")
    var textGray1: Color = Color(hex: "#5A5D62")
    var textBlack: Color = Color(hex: "#262B33")
    var oldBrandColor: Color = Color(hex: "#F83C00")
    var newBackgroundDisable: Color = Color(hex: "#E0E0E0")
    var newTextDisable: Color = Color(hex: "#999999")
    var backgroundRegisterButton: Color = Color(hex: "#00C036")
    var backgroundAccountView: Color = Color(hex: "#FD6B3C")
    var venetianRed: Color = Color(hex: "#FD6B3C")
    var blueText: Color = R.color.blueText.color
}
