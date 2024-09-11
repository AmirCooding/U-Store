//
//  Favorite_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//
import Foundation

class Favorite_ViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []
    @Published var favoriteProducts: [Product] = []  
    
    init(){
    }

    // Fetch all favorites and the corresponding products
    func fetchFavoritesAndProducts() async throws {
        favorites = try await UStore_RepositoryImpl.shared.fetchAllFavorites()
        favoriteProducts.removeAll()
        for favorite in favorites {
            let product = try await fetchProduct(productId: favorite.ProductId)
            favoriteProducts.append(product)
        }
    }

    // Fetch product details for a given productId
    func fetchProduct(productId: Int) async throws -> Product {
        return try await UStore_RepositoryImpl.shared.fetchProductById(productId: productId)
    }

    // Add product to favorite
    func addToFavorite(productId: Int) async throws {
        try  UStore_RepositoryImpl.shared.createFavorite(productId: productId)
        try await fetchFavoritesAndProducts()
    }

    // Remove product from favorite
    func deleteFavorite(favorite: Favorite) async throws {
        try await UStore_RepositoryImpl.shared.deleteFavorite(favorite: favorite)
        try await fetchFavoritesAndProducts()
    }
}
