//
//  Favorite_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//
import Foundation
import Combine
import os


@MainActor
class Favorite_ViewModel: ObservableObject {
    private var cartViewModel = Cart_ViewModel()
    private var repos : UStore_RepositoryImpl
    @Published var isLoading: Bool = false
    @Published var favoriteProducts: [Product] = []
    @Published var carts   = [CartItem]()
    @Published var favorites   = [Favorite](){
        didSet{
            Task{
                try await fetchFavoritesAndProducts()
            }
        }
    }
  
    var scriptions = Set<AnyCancellable>()
   /*
    var hasFavorites: Bool {
        !favorites.isEmpty
    }
    
    */
    init() {
        repos = UStore_RepositoryImpl()
        repos.fevoriets.assign(to: \.favorites , on: self).store(in: &scriptions)
      //  repos.carts.assign(to: \.carts , on: self).store(in: &scriptions)
     
     
    }
    
    
    func fetchFavoritesAndProducts() async throws {
        self.isLoading = true
        LoggerManager.logInfo("Count the favorites  in viewModel   fetch All Favorite: ---------------- > \(favorites.count)")
        favoriteProducts.removeAll()
        for favorite in favorites {
            let product = try await repos.fetchProductById(productId: favorite.ProductId)
            favoriteProducts.append(product)
        }
        LoggerManager.logInfo("Count the favoriteProducts  in viewModel   fetch All Products from Favorite: ---------------- > \(favoriteProducts.count)")
        self.isLoading = false
    }
    
    // MARK: - add Product to Cart
    func addToCart(productId: Int) async throws {
      
        if let selectedProduct = carts.first(where: { $0.ProductId == productId }) {
            let newQuantity = selectedProduct.quantity + 1
            try await repos.updateCartQuantity(productId: productId, newQuantity: newQuantity)
        } else {
            let product = try await repos.fetchProductById(productId: productId)
          //  try  repos.createCart(productId: productId)
            try repos.createCart(product: product)
        }
         
    }
    
    // Fetch product details for a given productId
    func fetchProductById(productId: Int) async throws -> Product {
        return try await repos.fetchProductById(productId: productId)
    }
    
    func addProductById(productId: Int) async throws  {
        try  repos.createFavorite(productId: productId)
    }
    
    // Delete a product from favorites by its productId
    func deleteFavoriteByProductId(productId: Int) async throws {
        if let favorite = favorites.first(where: { $0.ProductId == productId }) {
            LoggerManager.logInfo("------------------------ Found Favorite! --------------------")
            try await repos.deleteFavorite(favorite: favorite)
        } else {
            LoggerManager.logInfo("------------------------ No Favorite Found --------------------")
        }
    }
    

    
}

