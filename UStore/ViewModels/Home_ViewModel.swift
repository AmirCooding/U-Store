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
    func filterProductsByRatingAndPrice(min: Double?, max: Double?, selectedRating: Int, category: String) async throws -> [Product] {
        let products = await loadCategoryProducts(category: category)
        var filteredProducts = products
        let ratingRange = getRatingRange(selectedRating: selectedRating)

        if ratingRange != nil {
            filteredProducts = filteredProducts.filter { product in
                product.rating.rate ?? 0.00 >= ratingRange!.min && product.rating.rate ?? 0.00 < ratingRange!.max
                
            }
            LoggerManager.logInfo("rating by products rating : \(filteredProducts.count)")
        }

        if let min = min, let max = max {
            filteredProducts = filteredProducts.filter { product in
                product.currentPrice >= min && product.currentPrice <= max
            }
        } else if let min = min {
            filteredProducts = filteredProducts.filter { product in
                product.currentPrice >= min
            }
        } else if let max = max {
            filteredProducts = filteredProducts.filter { product in
                product.currentPrice <= max
            }
        }

        LoggerManager.logInfo("Products before filtering: \(products.count)")
        LoggerManager.logInfo("Filtered products count: \(filteredProducts.count)")
        
        return filteredProducts
    }

   
    private func getRatingRange(selectedRating: Int) -> (min: Double, max: Double)? {
        switch selectedRating {
        case 1:
            return (1.0, 2.0)
        case 2:
            return (2.0, 3.0)
        case 3:
            return (3.0, 4.0)
        case 4:
            return (4.0, 5.0)
        case 5:
            return (5, Double.greatestFiniteMagnitude)
        default:
            return nil 
        }
    }

    func filterProductsByPrice(min: Double, max: Double, category: String) async throws -> [Product] {
        let products = await loadCategoryProducts(category: category)
        let filteredProducts = products.filter { product in
            return product.currentPrice >= min && product.currentPrice <= max
        }
        LoggerManager.logInfo("Products before filtering: \(products.count)")
        LoggerManager.logInfo("Filtered products count: \(filteredProducts.count)")
        
        return filteredProducts
    }
    func filterProductsByRating(selectedRating: Int, category: String) async throws -> [Product] {
        let products = await loadCategoryProducts(category: category)
        let filteredProducts = products.filter { product in
            return selectedRating == 0 || (product.rating.rate ?? 0) == Double(selectedRating)
        }
        LoggerManager.logInfo("Products before filtering: \(products.count)")
        LoggerManager.logInfo("Filtered products count: \(filteredProducts.count)")
        
        return filteredProducts
    }

    
    
}

