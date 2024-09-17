//
//  UStore_Repositroy.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation
import Combine

protocol UStore_Repository {
    
    // MARK: -   User
    func signUp(email: String, password: String) async throws
    func signIn(email: String, password: String)async throws
    func resetPassword(email: String)async throws
    func signOut()throws
    var userIsLogin: Bool { get }
    
    // MARK: -  Categroy
    func loadingCategories() -> [ProductCategory]
    func fetchCategroy(category : String) async throws -> [Product]
    
   // MARK: - Asynchronous fetch from API
    func fetchAllProducts() async throws -> [Product]
    func fetchProductById(productId : Int)async throws -> Product
    
    // MARK: - CRUD Favorites
    func createFavorite(productId : Int) throws
    func fetchAllFavorites() async throws -> [Favorite]
    func deleteFavorite(favorite: Favorite) async throws
    var fevoriets : AnyPublisher <[Favorite] , Never> {get}
    
    
    // MARK: - CRUD Cart
    func createCart(product: Product) throws
    func updateCartQuantity(productId: Int, newQuantity: Int) async throws
    func fetchAllProductsFromCart() async throws -> [Cart]
    func deleteCart(cart: Cart) async throws
    var carts : [Cart] { get }
    
    
}

