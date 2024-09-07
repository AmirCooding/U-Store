//
//  GilroyFonts.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import Foundation

import SwiftUI


class GilroyFonts {
    
    
    enum FontStyle: String {
        case black = "Gilroy-Black"
        case bold = "Gilroy-Bold"
        case heavy = "Gilroy-Heavy"
        case light = "Gilroy-Light"
        case medium = "Gilroy-Medium"
        case regular = "Gilroy-Regular"
        case semiBold = "Gilroy-SemiBold"
        case thin = "Gilroy-Thin"
    
    }

    static func font(style: FontStyle, size: CGFloat) -> Font {
        return Font.custom(style.rawValue, size: size)
    }
}

