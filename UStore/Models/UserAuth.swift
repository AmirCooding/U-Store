//
//  UserAuth.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//


import Foundation


struct UserAuth : Codable {
    
    internal init(id: String, email: String) {
        self.id = id
        self.email = email

    }
    
    
    let id: String
    let email: String


}

