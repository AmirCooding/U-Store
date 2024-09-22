//
//  UserProfile.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//


import Foundation
import FirebaseFirestore


struct UserProfile: Codable, Identifiable {
    @DocumentID var id: String?
    var userId: String
    var fullName: String
    var email: String
    var tel: String
    var image: String?

    init(id: String? = nil, userId: String = "", fullName: String = "", email: String = "", tel: String = "", image: String? = nil) {
        self.id = id
        self.userId = userId
        self.fullName = fullName
        self.email = email
        self.tel = tel
        self.image = image
    }
}
