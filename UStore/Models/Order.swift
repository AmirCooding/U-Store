//
//  Order.swift
//  UStore
//
//  Created by Amir Lotfi on 23.09.24.
//

import Foundation

struct Order: Identifiable {
    let id = UUID()
    let itemName: String
    let orderDate: String
    let orderStatus: String
}
