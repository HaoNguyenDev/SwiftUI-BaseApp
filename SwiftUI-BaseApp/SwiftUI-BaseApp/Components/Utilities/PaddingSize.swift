//
//  AppPadding.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 23/10/25.
//

import Foundation
import CoreGraphics
import SwiftUI

struct PaddingSize {

// MARK: - A. Primary Layout Margins & Horizontal Spacing (Multiple of 8)

/// 16pt: Default horizontal padding for iPhone screen, spacing between large sections (standard content margin).
static let standard: CGFloat = 16.0

/// 8pt: Standard spacing between smaller or list elements (medium component spacing).
static let medium: CGFloat = 8.0

/// 24pt: Large spacing, often used under H1/H2 headings or between large View groups.
static let large: CGFloat = 24.0

/// 32pt: Very large spacing, used for Hero Sections or prominent spacing.
static let extraLarge: CGFloat = 32.0

// MARK: - B. Internal & Micro Spacing (Multiple of 4)

/// 4pt: Minimum inner padding, between icon and text, or items very close together.
static let tight: CGFloat = 4.0

/// 12pt: Medium spacing, often used as horizontal padding for small buttons or tab bars.
static let relaxed: CGFloat = 12.0

/// 20pt: Default horizontal padding for iPad/Mac screens.
static let wide: CGFloat = 20.0

// MARK: - C. Vertical Padding ⭐️

/// 8pt: Standard vertical padding, often used inside List Rows or Buttons to create space with text.
static let verticalDefault: CGFloat = 8.0

/// 12pt: More comfortable vertical padding for large buttons or content items.
static let verticalRelaxed: CGFloat = 12.0

/// 4pt: Small vertical padding, used for components with large natural height (Multi-line text) or to optimize space.
static let verticalTight: CGFloat = 4.0

// MARK: - D. Component Specific (Fixed size)

/// 44pt: Minimum height for the tap target according to HIG.
static let tapTarget: CGFloat = 44.0

/// 56pt: Standard height for the Navigation Bar when using a large title (Large Title).
static let navBarLarge: CGFloat = 56.0
}
