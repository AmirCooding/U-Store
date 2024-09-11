//
//  UStore_Repositroy.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation

protocol UStore_Repository {
    
    // MARK : User
    func signUp(email: String, password: String) async throws
    func signIn(email: String, password: String)async throws
    func resetPassword(email: String)async throws
    func signOut()throws
    var userIsLogin: Bool { get }
    
    

    
    // Asynchronous fetch from API
    func fetchAllProducts() async throws -> [Product]
    func fetchProductById(productId : Int)async throws -> Product
    
    // MARK : Favorite
    func createFavorite(productId : Int) throws
    func fetchAllFavorites() async throws -> [Favorite]
    func deleteFavorite(favorite: Favorite) async throws
    
}

