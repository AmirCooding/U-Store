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
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
