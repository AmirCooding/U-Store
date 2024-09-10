//
//  Product.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

extension Product {
    var artworkUrl: URL? {
        URL(string: image)
    }
}

extension Product {
    var discountedPrice: String {
        let discount = (price ) * 0.8
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "de_DE") // Euro locale
        return formatter.string(from: discount as NSNumber)!
    }
}

extension Product {
    var originalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "de_DE") // Euro locale
        return formatter.string(from: NSNumber(value: price)) ?? "0.00 €"
    }
}

extension Product {
    static var sample: Product {
        Product(id: 1, title: "Sample Product", price: 99.99, description: "This is a sample product description.", category: .electronics, image: "https://cdn.corporatefinanceinstitute.com/assets/product-mix3.jpeg", rating: Rating(rate: 3.9, count: 34))
    }
}

