//
//  UStoreApiService.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation
import Combine

class UStoreApiService{
    private let productsUrl = "https://fakestoreapi.com/products"
  
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: productsUrl) else { throw HttpError.invalidURL }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { throw HttpError.requestFailed }
        guard let result = try? JSONDecoder().decode([Product].self, from: data) else { throw HttpError.failedParsing  }
        let products = result
        return products
    }
    
  
    
    
}
