//
//  UStoreApp.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI
import Firebase

@main
struct UStoreApp: App {
    
    private var viewModel : UStore_UserAuth_ViewModel
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        viewModel = UStore_UserAuth_ViewModel()
        
    }
    var body: some Scene {
        WindowGroup {
            if viewModel.userIsLogin {
                Home_Screen()
            } else {
                SignIn_Screen()
            }
        }
     
        
    }
    
}
