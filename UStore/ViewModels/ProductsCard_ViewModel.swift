//
//  ProductsCard_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 12.09.24.
//

import Foundation
@MainActor
class ProductCard_ViewModle  : ObservableObject{
    private var repos : UStore_RepositoryImpl
    @Published var isLiked: Bool = false
    @Published var favorites: [Favorite] = []
    
    
    init() {
        
        repos = UStore_RepositoryImpl()
        Task{
            try await  fetchFavoritesAndProducts()
        }
    }
    
    
    func fetchFavoritesAndProducts() async throws  -> [Favorite]{
        favorites = try await repos.fetchAllFavorites()
        return favorites
    }
    
    func addToFavorite(productId: Int) async throws {
        self.isLiked = true
        try  repos.createFavorite(productId: productId)
    }

    func deleteFromeFavorite(favorit: Favorite) async throws {
        try await  repos.deleteFavorite(favorite: favorit)
    }
    
    func deleteFavoritebyId(productid : Int)async throws{
        self.isLiked = false
        for favorite in favorites {
            if favorite.ProductId == productid{
                try await deleteFromeFavorite(favorit: favorite)
            }
        }
    }
    
}



