//
//  Cart.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import FirebaseFirestore

struct Cart: Codable, Identifiable {
    internal init(id: String? = nil, userId: String, ProductId: Int, isFreeShgiping: Bool = false, quantity: Int, productPrice: Double, deliveryPrice: Double) {
        self.id = id
        self.userId = userId
        self.ProductId = ProductId
        self.isFreeShgiping = isFreeShgiping
        self.quantity = quantity
        self.productPrice = productPrice
        self.deliveryPrice = deliveryPrice
    }
    

    @DocumentID var id: String?
    var userId: String
    var ProductId: Int
    var isFreeShgiping: Bool = false
    var quantity: Int
    var productPrice: Double 
    var deliveryPrice: Double  = 5.99 

}


extension Cart {
    var shippingCost : Double {
        isFreeShgiping ? deliveryPrice : 5.99
    }
    

}


