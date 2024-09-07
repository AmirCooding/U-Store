//
//  FirbaseAuthService.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseAuth

 class FirbaseAuth {
     
     var user: User?
     var userAuth: UserAuth?

    var userIsLogin: Bool {
        user != nil
    }
     
    init() {
        checkAuth()
    }
     
     
     func createUser(id: String, email: String) {
         let user = UserAuth(id: id, email: email)
         do {
             try Firestore.firestore().collection("users").document(id).setData(from: user)
             print("User created successfully!")
         } catch {
             print("Error creating user: \(error.localizedDescription)")
         }
     }
     
     
     
     func getUser(id: String) {
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
                 let userAuth = try document.data(as: UserAuth.self)
                 self.userAuth = userAuth
                 print("User is fetched successfully!")
             } catch {
                 print("Error fetching user: \(error.localizedDescription)")
             }
         }
     }
     

    
    func signUp(username: String, password: String)  {
        auth.createUser(withEmail: username, password: password) { authResult, error in
            if let error {
                print("Registration failed: ", error.localizedDescription)
                return
            }
            guard let authResult, let email = authResult.user.email else {
                print("Cannot access authResult")
                return
            }
            print("User with email '\(email)' is registered with id '\(authResult.user.uid)'")
            self.createUser(id: authResult.user.uid, email: email)
            self.signIn(username: username, password: password)
        }
    }
    
    

    func signIn(username: String, password: String) {
        auth.signIn(withEmail: username, password: password) { authResult, error in
            if let error {
                print("Sign in failed: ", error.localizedDescription)
                return
            }
            guard let authResult, let email = authResult.user.email else {
                print("Cannot access authResult")
                return
            }
            print("User with email '\(email)' is signed in with id '\(authResult.user.uid)'")
            self.user = authResult.user
            self.getUser(id: authResult.user.uid)
        }
    }
    
    

    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
            print("User sign out succeeded!")
        } catch {
            print("Error signing out: ", error.localizedDescription)
        }
    }
    


    

    

    private func checkAuth() {
        guard let currentUser = auth.currentUser else {
            return
        }
        self.user = currentUser
    
        getUser(id: currentUser.uid)
    }

    private var auth = Auth.auth()
}

