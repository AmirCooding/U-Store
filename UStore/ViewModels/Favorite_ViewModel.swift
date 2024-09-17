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
 @Published var isLoading: Bool = false
 @Published var favoriteProducts: [Product] = []
 var favorites   = [Favorite]()
 var scriptions = Set<AnyCancellable>()
 
 var hasFavorites: Bool {
 !favorites.isEmpty
 }
 
 
 init() {
 repos = UStore_RepositoryImpl()
  repos.fevoriets.assign(to: \.favorites , on: self).store(in: &scriptions)
 LoggerManager.logInfo("Count the favorites  in viewModel   repo favorites count: ---------------- > \(repos.fevoriets.count())")
 }
 
 
 func fetchFavoritesAndProducts() async throws {
 LoggerManager.logInfo("Count the favorites  in viewModel   fetch All Favorite: ---------------- > \(favorites.count)")
 favoriteProducts.removeAll()
 for favorite in favorites {
 let product = try await repos.fetchProductById(productId: favorite.ProductId)
 self.isLoading = true
 favoriteProducts.append(product)
 self.isLoading = false
 }
 LoggerManager.logInfo("Count the favoriteProducts  in viewModel   fetch All Products from Favorite: ---------------- > \(favoriteProducts.count)")
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
 
 private var repos : UStore_RepositoryImpl
 private var cancellables = Set<AnyCancellable>()
 
 }
 
