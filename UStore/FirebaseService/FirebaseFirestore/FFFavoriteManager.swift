//
//  FireStoreFaivoriteManager.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FFFavoriteManager {
    private let dbCollection = Firestore.firestore().collection("favorites")
    private var listener: ListenerRegistration?
    private let user = FFUserManager.shared.appUser?.id
    
    
    // Create a favorite
    func createFavorite(productId: Int) throws {
        let favorite = Favorite(userId: user ?? "No ID from User for Adding in Favorite", ProductId: productId, isFavorite: true)
        do {
            let documentRef = try dbCollection.addDocument(from: favorite)
            print("Favorite created with ID: \(documentRef.documentID)")
        } catch {
            print("Error creating favorite: \(error.localizedDescription)")
            throw error
        }
    }
    
    // Delete a favorite
    func deleteFavorite(favorite: Favorite) async throws {
        guard let id = favorite.id else {
            LoggerManager.logMessageAndError("Failed to delete favorite from Firebase Firestore", error: HttpError.requestFailed)
            throw HttpError.requestFailed
        }
        try await dbCollection.document(id).delete()
    }
    
    // Fetch All Favorites
    func fetchAllFavorites() async throws -> [Favorite] {
        let snapshot = try await dbCollection.whereField("userId", isEqualTo: user ?? "No ID from User for Adding in Favorite").getDocuments()
        let   favorites = snapshot.documents.compactMap { document in
            try? document.data(as: Favorite.self)
        }
        LoggerManager.logInfo("Count of favorites fetched: \(favorites.count)")
        return favorites
    }
    
}
