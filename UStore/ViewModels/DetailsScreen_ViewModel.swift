//
//  DetailsScreen_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//

import Foundation

import Foundation
import Combine

@MainActor
class DetailsScreen_ViewModel: ObservableObject {
    private var repos: UStore_RepositoryImpl
    @Published var isLiked: Bool = false
    @Published var favorites: [Favorite] = []
    @Published var carts   : [CartItem] = []
    private var subscriptions = Set<AnyCancellable>() 
    var scriptions = Set<AnyCancellable>()
    init() {
        repos = UStore_RepositoryImpl()
        repos.fevoriets.assign(to: \.favorites , on: self).store(in: &scriptions)
        repos.carts.assign(to: \.carts , on: self).store(in: &scriptions)
          
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
            try await addProductFavoriteById(productId: productId)
        }
    }
    
    // MARK: - Add Product to Cart
    func addToCart(productId: Int) async throws {
        if let selectedProduct = carts.first(where: { $0.ProductId == productId }) {
            let newQuantity = selectedProduct.quantity + 1
            try await repos.updateCartQuantity(productId: productId, newQuantity: newQuantity)
        } else {
            let product = try await repos.fetchProductById(productId: productId)
           // try repos.createCart(productId: product.id)
            try repos.createCart(product: product)
        }
    }
    
    // MARK: - Add a Product to Favorites by its productId
    func addProductFavoriteById(productId: Int) async throws {
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
