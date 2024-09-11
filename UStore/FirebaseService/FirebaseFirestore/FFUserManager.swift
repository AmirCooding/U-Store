//
//  FireSotreManager.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseAuth

class FFUserManager {
    var appUser: AppUser?
    
    static let shared = FFUserManager()
    
    
    
    // Mark : Create User in Firebase Firestore
    func createUser(id: String, email: String) {
        let user = AppUser(id: id, email: email)
        do {
            try Firestore.firestore().collection("users").document(id).setData(from: user)
            print("User created successfully!")
        } catch {
            print("Error creating user: \(error.localizedDescription)")
        }
    }
    
    
    // Mark : Fetch User in Firebase Firestore
    func fetchUser(id: String) {
        Firestore.firestore().collection("users").document(id).getDocument { document, error in
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
