//
//  Font+Additional.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

import SwiftUI

protocol AppFont {
    func regular(_ size: CGFloat) -> Font
    func medium(_ size: CGFloat) -> Font
    func light(_ size: CGFloat) -> Font
    func bold(_ size: CGFloat) -> Font
    func italic(_ size: CGFloat) -> Font
    func semibold(_ size: CGFloat) -> Font
}

extension Font: AppFont {
    func regular(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Regular", size: size)
    }
    
    func medium(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Medium", size: size)
    }
    
    func light(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Light", size: size)
    }
    
    func bold(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Bold", size: size)
    }
    
    func italic(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Italic", size: size)
    }
    
    func semibold(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-SemiBold", size: size)
    }
    
}

struct Nunito: AppFont {
    func regular(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Regular", size: size)
    }
    
    func medium(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Medium", size: size)
    }
    
    func light(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Light", size: size)
    }
    
    func bold(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Bold", size: size)
    }
    
    func italic(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-Italic", size: size)
    }
    
    func semibold(_ size: CGFloat = 17) -> Font {
        Font.custom("Nunito-SemiBold", size: size)
    }
}
let mainFont = Nunito()
