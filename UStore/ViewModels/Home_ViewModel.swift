//
//  Home_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 14.09.24.
//

import Foundation
import Combine

@Observable  class Home_ViewModel   {
    var categories: [ProductCategory] = []
    var products: [Product] = []
    var productsForCategory : [Product] = []
    var bestSeller: [Product] = []
    var populerProducts: [Product] = []
    private var repos : UStore_RepositoryImpl
    
    init() {
        repos = UStore_RepositoryImpl()
        loadCategories()
        Task{
            await  loadProducts()
            await  loadBestsellers()
            await  loadPopulerProducts()
        }
    }
    
    //MARK: - Fetch all Products -
  
    private func loadProducts() async {
        do {
            products = try await repos.fetchAllProducts()
        } catch {
            let error = error as! HttpError
            print("Could not load Product data: \(error.description)")
        }
    }
    
    //MARK: - Method to load Best Seller products from the repository -
    private func loadBestsellers() async {
        let sortedProducts = products.sorted(by: { $0.rating.count! > $1.rating.count! })
        bestSeller = Array(sortedProducts.prefix(7))
        
    }
    
    
    //MARK: - Method to load Populare products from the repository -
   
    private func loadPopulerProducts() async {
        let sortedProducts = products.sorted(by: { $0.rating.rate! > $1.rating.rate! })
        populerProducts = Array(sortedProducts.prefix(7))
    }
    
    
    //MARK: - Method to load categories from the repository -
  
    func loadCategories() {
        self.categories = repos.loadingCategories()
    }
    
    //MARK: - Method to load Products by  Category -
   
    func loadCategoryProducts(category : String) async ->[Product] {
        do {
            self.productsForCategory = try await repos.fetchCategroy(category: category)
         //   print("Loaded Bestseller Products: \(self.productsForCategory)")
        } catch {
            if let httpError = error as? HttpError {
                print("Could not load Product data: \(httpError.description)")
            } else {
                print("An unknown error occurred: \(error.localizedDescription)")
            }
        }
        return self.productsForCategory
    }
    
//MARK: - Method to filter products by price -
    
    func filterProductsByPrice(min: Double, max: Double, category: String) async throws -> [Product] {
        let products = await loadCategoryProducts(category: category)
        let filteredProducts = products.filter { product in
            return product.currentPrice >= min && product.currentPrice <= max
        }
        LoggerManager.logInfo("Products before filtering: \(products.count)")
        LoggerManager.logInfo("Filtered products count: \(filteredProducts.count)")
        
        return filteredProducts
    }
    
    
}

