//
//  UStore_RepositoryImpl.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation
import Combine


struct UStore_RepositoryImpl : UStore_Repository{

    
    
 

    // MARK: - Call API
    func fetchAllProducts() async throws -> [Product] {try await api.fetchProducts()}
    func fetchProductById(productId: Int) async throws-> Product {try await api.fetchProductByIdsyn(productId: productId)}
    
    
    // MARK: - Firebase Autentication
    func signInWithGoogle() async throws {try await firebaseAuthManager.SigninWithGoogle()}
    var userIsLogin: Bool {firebaseAuthManager.isUserSignedIn}
    func signUp(email: String, password: String) async throws {try await firebaseAuthManager.signUp(email: email, password: password)}
    func signIn(email: String, password: String) async throws {try await firebaseAuthManager.signIn(email: email, password: password)}
    func signOut() throws{try firebaseAuthManager.signOut()}
    func resetPassword(email: String) async throws{try await firebaseAuthManager.resetPassword(email: email)}
    
    // MARK: - CRUD Favorite
    func createFavorite(productId: Int) throws {try FFFavoriteManager.shared.createFavorite(productId: productId)}
    func fetchAllFavorites() async throws -> [Favorite] { try await FFFavoriteManager.shared.fetchAllFavorites()}
    func deleteFavorite(favorite: Favorite) async throws {try await FFFavoriteManager.shared.deleteFavorite(favorite: favorite)}
    var fevoriets: AnyPublisher<[Favorite], Never> {FFFavoriteManager.shared.$favorites.eraseToAnyPublisher()}
   // var fevoriets: AnyPublisher <[Favorite] , Never> { FFFavoriteManager.shared.favorites.publisher.collect().eraseToAnyPublisher()}
    
    // MARK: -CRUD Cart
    func createCart(product: Product ) throws {   try FFCartManager.shared.createCart(product: product)}
    func fetchAllProductsFromCart() async throws -> [Cart] {try await FFCartManager.shared.fetchAllProductdFromCart()}
    func updateCartQuantity(productId: Int, newQuantity: Int) async throws {try await FFCartManager.shared.updateCartQuantity(productId: productId, newQuantity: newQuantity)}
    func deleteCart(cart: Cart) async throws {try await FFCartManager.shared.deleteCart(cart: cart)}
    var carts: [Cart] { FFCartManager.shared.carts}
    
    // MARK: - Supply Categroies
    func fetchCategroy(category: String) async throws -> [Product] {  try await api.fetchCategroy(category: category)}
    func loadingCategories() -> [ProductCategory] {
        return [
            ProductCategory(id:1,title: "" , category: Category.womenSClothing, image: "womens"),
            ProductCategory(id:2,title: "" , category: Category.menSClothing, image: "mens"),
            ProductCategory(id:3,title: "" , category: Category.jewelery, image: "jewelry"),
            ProductCategory(id:4,title: "", category: Category.electronics, image: "electronics"),
               ]
    }

    private var firebaseAuthManager = FAuthManager()
    private var api = UStoreApiService()
    
}
