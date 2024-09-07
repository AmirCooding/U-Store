//
//  Colors.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//


import Foundation
import UIKit
import SwiftUI


/// An enumeration that provides a centralized color management system for the project.
///
/// This enum defines a set of colors used throughout the application, allowing for
/// easy customization and consistent color usage across different views.
/// Each case in the enum represents a specific color that can be accessed in both
/// UIKit (`UIColor`) and SwiftUI (`Color`) contexts.
///
/// Usage:
/// - Use the `uiColor()` method to retrieve a `UIColor` for use in UIKit components.
/// - Use the `color()` method to retrieve a `Color` for use in SwiftUI components.
///
/// Example:
/// ```
/// let primaryColor: Color = Colors.primary.color()
/// let backgroundColor: UIColor = Colors.white.uiColor()
/// ```
enum Colors {
    case white
    case black
    case primary
    case secondary
    case google
    case faceBook
    case error

    func uiColor() -> UIColor {
        switch self {
        case .white:
            return .white
        case .black:
            return UIColor(hex: "#181725")
        case .primary:
            return UIColor(hex: "#0E3493")
        case .secondary :
            return UIColor(hex: "#7C7C7C")
        case .google :
            return UIColor(hex: "#5383EC")
        case .faceBook :
            return UIColor(hex: "#4A66AC")
        case .error :
            return UIColor(hex: "#FF3838")
            
        }
    }

    /// Returns the corresponding `Color` for each enum case for SwiftUI.
    func color() -> Color {
        return Color(self.uiColor())
    }
}

// Extension to convert hex string to UIColor
extension UIColor {
    convenience init(hex: String) {
        
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

