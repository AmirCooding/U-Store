//
//  AppUser.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import FirebaseFirestore

struct AppUser : Codable{
    
    internal init(id: String, email: String) {
        self.id = id
        self.email = email
    }
    
    let id: String
    let email: String
    
}
