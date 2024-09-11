//
//  Utilities.swift
//  UStore
//
//  Created by Amir Lotfi on 08.09.24.
//

import Foundation
import UIKit


import UIKit

final class Utilities {
    static let shared = Utilities()
    private init() {}
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        // Use scene-based approach for iOS 13 and later
        var rootViewController: UIViewController?
        if #available(iOS 13.0, *) {
            // Get the first active window scene
            let keyWindow = UIApplication.shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }        // Get UIWindowScene instances
                .flatMap { $0.windows }                     // Get all windows for those scenes
                .first { $0.isKeyWindow }                   // Find the key window
            
            rootViewController = keyWindow?.rootViewController
        } else {
            // Fallback for older iOS versions
            rootViewController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        // Use the passed controller if it's not nil, otherwise use rootViewController
        let controller = controller ?? rootViewController

        // Handle navigation controllers
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }

        // Handle tab bar controllers
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }

        // Handle presented view controllers
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }

        return controller
    }
}

