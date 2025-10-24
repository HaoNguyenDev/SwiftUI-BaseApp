//
//  View+Additional.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

// MARK: - RoundedCorner
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        return Path(path.cgPath)
    }
}

extension View {
    func roundCorners(
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func roundedBorder(
        cornerRadius: CGFloat,
        lineWidth: CGFloat = 1,
        borderColor: Color = .clear
    ) -> some View {
        overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: lineWidth)
        )
    }
}
