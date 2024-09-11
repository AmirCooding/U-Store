//
//  FireStoreFaivoriteManager.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


import Foundation
import FirebaseFirestore

class FFFavoriteManager {
    var user: User?
    
    init() {
        user = FAuthManager.shared.user
    }

    func createFavorite(productId: Int) throws {
        guard let userId = FFUserManager.shared.appUser?.id else {
            print("User is not authenticated or user ID is missing")
            throw NSError(domain: "com.UStore.favorite", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not logged in"])
        }
        let db = Firestore.firestore()
        let favorite = Favorite(userId: userId, ProductId: productId , isFavorite: true)
        do {
            let documentRef = try db.collection("favorites").addDocument(from: favorite)
            print("Favorite created with ID: \(documentRef.documentID)")
        } catch {
            print("Error creating favorite: \(error.localizedDescription)")
            throw error
        }
    }
    

    func deleteFavorite(favorite: Favorite) async throws {
        let db = Firestore.firestore()
        guard let favoriteId = favorite.id else {
            print("Favorite does not have a valid document ID.")
            throw NSError(domain: "com.UStore.favorite", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid Favorite ID"])
        }
        let favoriteRef = db.collection("favorites").document(favoriteId)
        do {
            try await favoriteRef.setData([
                "isFavorite": false
            ], merge: true)
            print("Favorite with ID: \(favoriteId) marked as not favorite successfully")
        } catch {
            print("Error marking favorite as not favorite: \(error.localizedDescription)")
            throw error
        }
    }

    
    func fetchAllFavorites() async throws -> [Favorite] {
        guard let userId = FFUserManager.shared.appUser?.id else {
            print("User is not authenticated or user ID is missing")
            throw NSError(domain: "com.UStore.favorite", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not logged in"])
        }
        let db = Firestore.firestore()
        let favoritesCollection = db.collection("favorites")
        let query = favoritesCollection.whereField("userId", isEqualTo: userId)
        do {let snapshot = try await query.getDocuments()
            let favorites = snapshot.documents.compactMap { document -> Favorite? in try? document.data(as: Favorite.self)}
            return favorites
        } catch {
            print("Error fetching favorites: \(error.localizedDescription)")
            throw error
        }
    }

    
    

}

