//
//  UStore_RepositoryImpl.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation


struct UStore_RepositoryImpl : UStore_Repository{
  
    
 

     static let shared = UStore_RepositoryImpl()
   
    
  ///------------- Call API -----------------------------------
    ///
    func fetchAllProducts() async throws -> [Product] {try await api.fetchProducts()}
    func fetchProductById(productId: Int) async throws-> Product { try await api.fetchProductById(productId: productId)}
 

 ///------------- Firebase Autentication -----------------------------------
    
    func signInWithGoogle() async throws {try await firebaseAuthManager.SigninWithGoogle()}
    var userIsLogin: Bool {firebaseAuthManager.isUserSignedIn}
    func signUp(email: String, password: String) async throws {try await firebaseAuthManager.signUp(email: email, password: password)}
    func signIn(email: String, password: String) async throws {try await firebaseAuthManager.signIn(email: email, password: password)}
    func signOut() throws{try firebaseAuthManager.signOut()}
    func resetPassword(email: String) async throws{try await firebaseAuthManager.resetPassword(email: email)}
    
    
///------------- CRUD Favorite -----------------------------------
    func createFavorite(productId: Int) throws {try favoriteManager.createFavorite(productId: productId)}
    func fetchAllFavorites() async throws -> [Favorite] { try await favoriteManager.fetchAllFavorites()}
    func deleteFavorite(favorite: Favorite) async throws {try await favoriteManager.deleteFavorite(favorite: favorite)}
    
   
    private let favoriteManager = FFFavoriteManager()
    private var firebaseAuthManager = FAuthManager()
    private var api = UStoreApiService()
    
}
