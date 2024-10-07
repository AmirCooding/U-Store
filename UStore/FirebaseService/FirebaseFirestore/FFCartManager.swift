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
    @Published var carts: [CartItem]  = []
    private let dbCollection = Firestore.firestore().collection("carts")
    private let subject = PassthroughSubject<[CartItem], Never>()
    private var listener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - Initialization -
    
    private init() {
        Task{
            try  addListenerForAllUserCartProducts()
        }
   /*
        // Set up a snapshot listener to automatically update the carts list
        listener = dbCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error listening to Firestore: \(error)")
                return
            }
            
            let updatedCarts = snapshot?.documents.compactMap { snapshot in
                try? snapshot.data(as: CartItem.self)
            } ?? []
            
            print("Fetched \(updatedCarts.count) cart from snapshot listener")
            // Send the updated carts through the Combine subject
            self.subject.send(updatedCarts)
        }
        
        // Subscribe to subject and update the local carts array when changes occur
        subject.sink { carts in
            self.carts = carts
        }.store(in: &cancellables)
    */
    }
    
    // Listener für alle Cart-Produkte des aktuellen Benutzers
    func addListenerForAllUserCartProducts() throws {
        // Sicherstellen, dass die Benutzer-ID vorhanden ist
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No valid user ID to listen for cart products")
            throw AuthError.invalidUser
        }

        // Listener hinzufügen, der auf alle Änderungen für den Benutzer lauscht
        listener = dbCollection
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                // Fehlerbehandlung
                if let error = error {
                    print("Error listening for cart products: \(error)")
                    return
                }
                
                // Extrahiere die Cart-Items aus dem Snapshot
                guard let documents = querySnapshot?.documents else {
                    print("No documents in cart snapshot")
                    return
                }
                
                // Versuche, die Dokumente in CartItem-Objekte zu dekodieren
                let updatedCarts = documents.compactMap { document in
                    try? document.data(as: CartItem.self)
                }
                
                // Aktualisiere die Liste der Carts und sende sie über Combine
                self.carts = updatedCarts
                self.subject.send(updatedCarts)
            }
    }

    // MARK: - Create Cart -
    
    func createCart(product : Product) throws {
        guard let userId =  Auth.auth().currentUser?.uid else {
            print("No valid user ID to create favorite")
            return
        }
        let cart = CartItem( userId: userId, ProductId: product.id , isFreeShgiping: true , quantity: 1 , productPrice: product.currentPrice , deliveryPrice: 5.99)
        do {
            let documentRef = try dbCollection.addDocument(from: cart)
            print("Favorite created with ID: \(documentRef.documentID)")
        } catch {
            print("Error creating favorite: \(error.localizedDescription)")
            throw error
        }
    }
    
    // MARK: - Update Cart Productsquantity  -
    
    func updateCartQuantity(productId: Int, newQuantity: Int) async throws {
        guard let userId =  Auth.auth().currentUser?.uid else {
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
    
    
    
    
    // MARK: - Delete Cart -
    
    func deleteCart(cart: CartItem) async throws {
        guard let id = cart.id else {
            print("Failed to delete carts: no document ID")
            throw HttpError.requestFailed
        }
        try await dbCollection.document(id).delete()
    }
    
    // MARK: - Fetch All Carts (one-time fetch) -
    
    func fetchAllProductsFromCart() async throws {
        guard let userId =  Auth.auth().currentUser?.uid else {
            print("No valid user ID to update cart")
             throw AuthError.invalidUser
        }
        LoggerManager.logInfo(" user id fetch Cart -----------------> : \(userId)")
        let snapshot = try await dbCollection.whereField("userId", isEqualTo: userId ).getDocuments()
        let fetchCarts = snapshot.documents.compactMap { document in
            try? document.data(as: CartItem.self)
        }
        self.carts = fetchCarts
    }
    
    
    // MARK: - Delete all products from the cart for the current user -
       
    func deleteAllProductsForCurrentUser() async throws {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("No valid user ID to delete cart")
                throw AuthError.invalidUser
            }
            LoggerManager.logInfo(" user id delete Cart -----------------> : \(userId)")

            let snapshot = try await dbCollection.whereField("userId", isEqualTo: userId).getDocuments()

            for document in snapshot.documents {
                try await dbCollection.document(document.documentID).delete()
            }
            LoggerManager.logInfo("All cart items deleted for user ID: \(userId)")
        }
    
    // MARK: - Remove Cart Listener -
    func removeCartListener() {
        carts = []
        listener?.remove()
        listener = nil
    }
    
}

