//
//  Explore_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//


import Foundation


@Observable class Explore_ViewModel{
    var products: [Product] = []
    private let repos : UStore_RepositoryImpl
    
    
    init() {
         repos = UStore_RepositoryImpl()
         Task{
            try  await  loadProducts()
                   
         }
     }
    
    //Fetch all Products
    private func loadProducts() async throws {
        do {
            products = try await repos.fetchAllProducts()
        } catch {
            let error = error as! HttpError
            print("Could not load Product data: \(error.description)")
        }
    }
    
    
    
    func filterProductsByTitle(searchText : String, products : [Product]) -> [Product] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    
    func filterProductsByPrice(min : Double , max : Double){
        //TODO filter by price
    }
    
    
    
}

