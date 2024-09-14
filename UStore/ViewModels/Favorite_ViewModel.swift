//
//  Favorite_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//
import Foundation
import os
@MainActor
class Favorite_ViewModel: ObservableObject {
    private var repos : UStore_RepositoryImpl
    @Published var isLoading: Bool = false
    @Published var favorites: [Favorite] = []
    @Published var favoriteProducts: [Product] = []
    
    init() {
        repos = UStore_RepositoryImpl()
        Task{
            try await fetchFavoritesAndProducts()
            
        }
    }
    
    func fetchFavoritesAndProducts() async throws {
        self.isLoading = true
        favorites = try await repos.fetchAllFavorites()
        favoriteProducts.removeAll()
        for favorite in favorites {
            let product = try await repos.fetchProductById(productId: favorite.ProductId)
            favoriteProducts.append(product)
            self.isLoading = false
        }
    
    }
    
    // Fetch product details for a given productId
    func fetchProductById(productId: Int) async throws -> Product {
        return try await repos.fetchProductById(productId: productId)
    }
 
    func deleteFromFavorite(favorite: Favorite) async throws {
        try await repos.deleteFavorite(favorite: favorite)
        favorites.removeAll { $0.ProductId == favorite.ProductId }
    }
    
    // Delete a product from favorites by its productId
    func deleteFavoriteByProductId(productId: Int) async throws {
        LoggerManager.logInfo("Trying to delete favorite with ProductId: \(productId)")
        for favorite in favorites {
            LoggerManager.logInfo("Existing favorite ProductId: \(favorite.ProductId)")
        }

        if let favorite = favorites.first(where: { $0.ProductId == productId }) {
            LoggerManager.logInfo("------------------------ Found Favorite! --------------------")
            try await deleteFromFavorite(favorite: favorite)
        } else {
            LoggerManager.logInfo("------------------------ No Favorite Found --------------------")
        }
    }


}
