//
//  AppUser.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import FirebaseFirestore

struct AppUser : Codable{
    internal init(userId: String, email: String) {
        self.userId = userId
        self.email = email
    }
    
    let userId: String
    let email: String
    
}
