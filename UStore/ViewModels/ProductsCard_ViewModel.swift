//
//  ProductsCard_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 12.09.24.
//
import Foundation
import Combine

@MainActor
class ProductCard_ViewModel: ObservableObject {
    private var repos: UStore_RepositoryImpl
    @Published var isLiked: Bool = false
    @Published var favorites: [Favorite] = []
    
    var carts: [Cart] {
        repos.carts
    }
    
    private var subscriptions = Set<AnyCancellable>() // Store subscriptions here
    
    init() {
        repos = UStore_RepositoryImpl()
        repos.fevoriets
            .receive(on: DispatchQueue.main)
            .assign(to: &$favorites)
        
    }
    
    func toggleColorFavoriteIcon(productId: Int) async throws {
        if let _ = favorites.first(where: { $0.ProductId == productId }) {
            isLiked = true
        } else{
            isLiked = false
        }
    }
    
    func toggleFavorites(productId: Int) async throws {
        if let _ = favorites.first(where: { $0.ProductId == productId }) {
            isLiked.toggle()
           try await deleteFavoriteByProductId(productId: productId)
        } else{
            isLiked.toggle()
            try await addProductById(productId: productId)
        }
    }
    
    // MARK: - Add Product to Cart
    func addToCart(productId: Int) async throws {
        if let selectedProduct = carts.first(where: { $0.ProductId == productId }) {
            let newQuantity = selectedProduct.quantity + 1
            try await repos.updateCartQuantity(productId: productId, newQuantity: newQuantity)
        } else {
            let product = try await repos.fetchProductById(productId: productId)
            try repos.createCart(product: product)
        }
    }
    
    // MARK: - Add a Product to Favorites by its productId
    func addProductById(productId: Int) async throws {
        try repos.createFavorite(productId: productId)
    }
    
    // MARK: - Delete a Product from Favorites by its productId
    func deleteFavoriteByProductId(productId: Int) async throws {
        if let favorite = favorites.first(where: { $0.ProductId == productId }) {
            LoggerManager.logInfo("------------------------ Found Favorite! --------------------")
            try await repos.deleteFavorite(favorite: favorite)
            isLiked = false
        } else {
            LoggerManager.logInfo("------------------------ No Favorite Found --------------------")
        }
    }
}
