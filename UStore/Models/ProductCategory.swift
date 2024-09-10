//
//  ProductCategory.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation

struct ProductCategory  : Identifiable, Hashable{
    internal init(id: Int, title: String, category: Category, image: String) {
        self.id = id
        self.title = title
        self.category = category
        self.image = image
    }
    

    let id : Int
    let title : String
    let category: Category
    let image : String

}

extension ProductCategory {
    static var sampleCategory: ProductCategory {
        ProductCategory(id:1,title: "WOMAN'S" , category: Category.electronics, image: "womens")
    }
    
    
}
