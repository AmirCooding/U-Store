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



class FFFavoriteManager  : ObservableObject{
    static let shared = FFFavoriteManager()
    @Published var favorites: [Favorite] = []
    private let dbCollection = Firestore.firestore().collection("favorites")
    private let subject = PassthroughSubject<[Favorite], Never>()
    private var listener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()

    
    // MARK: - Initialization -
   
    private init() {
        // Set up a snapshot listener to automatically update the carts list
        listener = dbCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error listening to Firestore: \(error)")
                return
            }
     
            let updatedFavorites = snapshot?.documents.compactMap { snapshot in
                try? snapshot.data(as: Favorite.self)
            } ?? []
            
            print("Fetched \(updatedFavorites.count) favorites from snapshot listener")

            // Send the updated favorites through the Combine subject
            self.subject.send(updatedFavorites)
        }
        subject.sink { favorites in
            self.favorites = favorites
        }.store(in: &cancellables)
    }
    
    func addListenerForAllUserFavoritesProducts() async throws{
        dbCollection.addSnapshotListener{querySnapshot , error in
        }
    }
    
    // MARK: - Create Favorite -
    
    func createFavorite(productId: Int) throws {
        guard let userId =  Auth.auth().currentUser?.uid else {
            print("No valid user ID to create favorite")
            return
        }
        let favorite = Favorite(userId: userId, ProductId: productId, isFavorite: true)
        
        do {
            try dbCollection.addDocument(from: favorite)
          // try dbCollection.document(userId).setData(from : favorite)
            LoggerManager.logInfo("Favorite is created with User ID \(userId) ")
        } catch {
            print("Error creating favorite: \(error.localizedDescription)")
            throw error
        }
    }
    
    
   
    // MARK: - Delete Favorite -
   
    func deleteFavorite(favorite: Favorite) async throws {
        guard let id = favorite.id else {
            LoggerManager.logInfo("Failed to delete favorite: no document ID")
            throw HttpError.requestFailed
        }
        try await dbCollection.document(id).delete()
    }
    
    
    // MARK: - Fetch All Favorites (one-time fetch) -
   
    func fetchAllFavorites() async throws -> [Favorite] {
        guard let userId =  Auth.auth().currentUser?.uid else {
            print("No valid user ID to create favorite")
            throw AuthError.invalidUser
        }
        let snapshot = try await dbCollection.whereField("userId", isEqualTo: userId).getDocuments()
        let fetchedFavorites = snapshot.documents.compactMap { document in
            try? document.data(as: Favorite.self)
        }
        LoggerManager.logInfo("Fetched \(fetchedFavorites.count) favorites in FFFavoriteManager for USer ID \(userId)")
        DispatchQueue.main.async {
            self.favorites = fetchedFavorites
        }
        
        return fetchedFavorites
    }

    // MARK: - Remove Listener -
  
    func removeFavoriteListener() {
      favorites = []
      listener?.remove()
      listener = nil
    }
    
}
