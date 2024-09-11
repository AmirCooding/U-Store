//
//  Favorite.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import FirebaseFirestore


struct Favorite: Codable , Identifiable {
    
    internal init(id: String? = nil, userId: String, ProductId: Int, isFavorite: Bool = false) {
        self.id = id
        self.userId = userId
        self.ProductId = ProductId
        self.isFavorite = isFavorite
    }

    @DocumentID var id: String?
    var userId: String
    var ProductId: Int
    var isFavorite : Bool = false
}



