//
//  UStoreApp.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI
import OSLog
import Firebase

@main
struct UStoreApp: App {
   static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: UStoreApp.self)
    )

    private var viewModel : UStore_UserAuth_ViewModel
    
    
    init()  {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        viewModel = UStore_UserAuth_ViewModel()
    }
    var body: some Scene {
        WindowGroup {
            if viewModel.userIsLogin {
                Navigatoreator_Screen()
            } else {
                SignIn_Screen()
            }
        }
    }
    
}
