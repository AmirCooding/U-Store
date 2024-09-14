//
//  UStoreApiService.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation
import Combine

class UStoreApiService{
    
    static let sheard = UStoreApiService()
    private let productsUrl = "https://fakestoreapi.com/products"
   /*
    init(){
        Task{
            LoggerManager.logInfo("Test favorite product befor to achieve product in Api Service class")
            do{
                let product = try await fetchProductById(productId: 1)
                LoggerManager.logInfo("Test favorite product  \(product.title)")
            }catch{
                LoggerManager.logMessageAndError("can not fetch data from Api by Id on Api service class ", error: HttpError.requestFailedFetchProductById)
            }
                
        }
    }
  */
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: productsUrl) else { throw HttpError.invalidURL }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { throw HttpError.requestFailed }
        guard let result = try? JSONDecoder().decode([Product].self, from: data) else { throw HttpError.failedParsing  }
        let products = result
        return products
    }
    
    
    func fetchCategroy(category : String) async throws -> [Product] {
        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? category
        let productsUrl = "https://fakestoreapi.com/products/category/\(encodedCategory)"
        guard let url = URL(string: productsUrl) else { throw HttpError.invalidURL }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { throw HttpError.requestFailed }
        guard let result = try? JSONDecoder().decode([Product].self, from: data) else { throw HttpError.failedParsing  }
        let products = result
    
        return products
    }
    




    func fetchProductByIdsyn(productId: Int) async throws -> Product {
        let urlString = "https://fakestoreapi.com/products/\(productId)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let product = try JSONDecoder().decode(Product.self, from: data)
        return product
    }


    func fetchProductById(productId : Int) async throws -> Product {
        let productsUrl = "https://fakestoreapi.com/products/\(productId)"
        guard let url = URL(string: productsUrl) else { throw HttpError.invalidURL }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            LoggerManager.logHttpError(HttpError.requestFailedFetchProductById)
            throw HttpError.requestFailed
        }
        guard let result = try? JSONDecoder().decode([Product].self, from: data) else { throw HttpError.failedParsing}
        guard let product = result.first else { throw HttpError.noProductFound }
        print(product.title)
        return product
    }

    
  
    
    
}
