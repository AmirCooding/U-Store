//
//  FFCartManager.swift
//  UStore
//
//  Created by Amir Lotfi on 14.09.24.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine



class FFCartManager  {
    static let shared  = FFCartManager()
    @Published var carts: [Cart] = []
    private let dbCollection = Firestore.firestore().collection("carts")
    private let subject = PassthroughSubject<[Cart], Never>()
    private var listener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    private let userId = FFUserManager.shared.auth.currentUser?.uid
    
    // MARK: - Initialization
    private init() {
        // Set up a snapshot listener to automatically update the carts list
        listener = dbCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error listening to Firestore: \(error)")
                return
            }
            
            let updatedCarts = snapshot?.documents.compactMap { snapshot in
                try? snapshot.data(as: Cart.self)
            } ?? []
            
            print("Fetched \(updatedCarts.count) cart from snapshot listener")
            // Send the updated carts through the Combine subject
            self.subject.send(updatedCarts)
        }
        
        // Subscribe to subject and update the local carts array when changes occur
        subject.sink { carts in
            self.carts = carts
        }.store(in: &cancellables)
    }
    
    func addListenerForAllUserCartProducts() async throws{
        dbCollection.addSnapshotListener{querySnapshot , error in
        }
    }
    
    
    // MARK: - Create Favorite
    func createCart(product : Product) throws {
        guard let userId = userId else {
            print("No valid user ID to create favorite")
            return
        }
        let cart = Cart( userId: userId, ProductId: product.id , isFreeShgiping: true , quantity: 1 , productPrice: product.currentPrice , deliveryPrice: 5.99)
        do {
            let documentRef = try dbCollection.addDocument(from: cart)
            print("Favorite created with ID: \(documentRef.documentID)")
        } catch {
            print("Error creating favorite: \(error.localizedDescription)")
            throw error
        }
    }
    
    // MARK: - Update Cart Quantity
    func updateCartQuantity(productId: Int, newQuantity: Int) async throws {
        guard let userId = userId else {
            print("No valid user ID to update cart")
            return
        }
        let snapshot = try await dbCollection
            .whereField("userId", isEqualTo: userId)
            .whereField("ProductId", isEqualTo: productId)
            .getDocuments()

        guard let document = snapshot.documents.first else {
            print("No cart found for this product")
            return
        }
        
        try await dbCollection.document(document.documentID).updateData([
            "quantity": newQuantity
        ])
        
        print("Cart updated with new quantity: \(newQuantity)")
    }

    
    
    
    // MARK: - Delete Favorite
    func deleteCart(cart: Cart) async throws {
        guard let id = cart.id else {
            print("Failed to delete carts: no document ID")
            throw HttpError.requestFailed
        }
        try await dbCollection.document(id).delete()
    }
    
    // MARK: - Fetch All Favorites (one-time fetch)
    func fetchAllProductdFromCart() async throws -> [Cart] {
        let snapshot = try await dbCollection.whereField("userId", isEqualTo: userId ?? "No ID").getDocuments()
        let fetchCarts = snapshot.documents.compactMap { document in
            try? document.data(as: Cart.self)
        }
        print("Fetched \(carts.count) favorites")
        DispatchQueue.main.async {
            self.carts = fetchCarts
        }
        return carts
    }
    
    // MARK: - Remove Listener
    func removeListener() {
        carts = []
        listener?.remove()
        listener = nil
    }
    
}


