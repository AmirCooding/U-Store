//
//  FireSotreManager.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation
import Firebase
import FirebaseAuth

class FFUserManager {
    var appUser: AppUser?
    private let dbCollection = Firestore.firestore().collection("users")
    static let shared = FFUserManager()
    var auth = Auth.auth()

    // MARK:  -Create User in Firebase Firestore-
    func createUser(id: String, email: String) {
        let user = AppUser(userId: id, email: email)
        do {
            try dbCollection.document(id).setData(from: user)
            print("User created successfully!")
        } catch {
            print("Error creating user: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: -Fetch User in Firebase Firestore -
    func fetchUser(id: String) {
        dbCollection.document(id).getDocument { document, error in
            if let error {
                print("Fetch user failed: \(error.localizedDescription)")
                return
            }
            guard let document else {
                print("Document with id: \(id) not found")
                return
            }
            do {
                let user = try document.data(as: AppUser.self)
                self.appUser = user
                print("User is fetched successfully!")
            } catch {
                print("Error fetching user: \(error.localizedDescription)")
            }
        }
    }
    

    
    
}
