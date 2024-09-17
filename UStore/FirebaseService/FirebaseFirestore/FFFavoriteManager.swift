//
//  FireStoreFaivoriteManager.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine



import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine


class FFFavoriteManager  : ObservableObject{
    static let shared = FFFavoriteManager()
    @Published var favorites: [Favorite] = []
    private let dbCollection = Firestore.firestore().collection("favorites")
    private let subject = PassthroughSubject<[Favorite], Never>()
    private var listener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    private let userId = FFUserManager.shared.auth.currentUser?.uid
    
    // MARK: - Initialization
    private init() {
        listener = dbCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error listening to Firestore: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents in favorites collection")
                return
            }
            
            let updatedFavorites = documents.compactMap { snapshot in
                try? snapshot.data(as: Favorite.self)
            }
            
            print("Fetched \(updatedFavorites.count) favorites from snapshot listener")
            

            // Send the updated favorites through the Combine subject
            self.subject.send(updatedFavorites)
        }
        
        
        // Subscribe to subject and update the local favorites array when changes occur
        subject.sink { favorites in
            self.favorites = favorites
        }.store(in: &cancellables)
    }
    
    func addListenerForAllUserFavoritesProducts() async throws{
        dbCollection.addSnapshotListener{querySnapshot , error in
        }
    }
    
    // MARK: - Create Favorite
    func createFavorite(productId: Int) throws {
        guard let userId = userId else {
            print("No valid user ID to create favorite")
            return
        }
        let favorite = Favorite(userId: userId, ProductId: productId, isFavorite: true)
        
        do {
            let documentRef = try dbCollection.addDocument(from: favorite)
            print("Favorite created with ID: \(documentRef.documentID)")
        } catch {
            print("Error creating favorite: \(error.localizedDescription)")
            throw error
        }
    }
    
    
    // MARK: - Delete Favorite
    func deleteFavorite(favorite: Favorite) async throws {
        guard let id = favorite.id else {
            print("Failed to delete favorite: no document ID")
            throw HttpError.requestFailed
        }
        try await dbCollection.document(id).delete()
    }
    // MARK: - Fetch All Favorites (one-time fetch)
    func fetchAllFavorites() async throws -> [Favorite] {
        let snapshot = try await dbCollection.whereField("userId", isEqualTo: userId ?? "No ID").getDocuments()
        let fetchedFavorites = snapshot.documents.compactMap { document in
            try? document.data(as: Favorite.self)
        }
        print("Fetched \(fetchedFavorites.count) favorites in FFFavoriteManager")
        DispatchQueue.main.async {
            self.favorites = fetchedFavorites
        }
        
        return fetchedFavorites
    }

    // MARK: - Remove Listener
    func removeListener() {
        favorites = []
        listener?.remove()
        listener = nil
    }
    
}


