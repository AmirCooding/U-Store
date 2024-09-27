//
//  UserAddress.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import FirebaseFirestore

struct UserAddress : Codable {
    internal init(street: String = "", number: String = "", city: String = "", state: String? = "", zipCode: String = "", country: String? = "") {
        self.street = street
        self.number = number
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.country = country
    }
    
 
    
  
    var street: String = ""
    var number : String = ""
    var city: String = ""
    var state: String? = ""
    var zipCode: String = ""
    var country: String? = ""

}


    
