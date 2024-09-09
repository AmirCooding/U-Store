//
//  UStore_RepositoryImpl.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation


struct UStore_RepositoryImpl : UStore_Repository{
 
    
    func signInWithGoogle() async throws {
        try await firebaseAuthManager.SigninWithGoogle()
    }
    
    var userIsLogin: Bool {
          firebaseAuthManager.isUserSignedIn
      }

    
 
    func signUp(email: String, password: String) async throws {
       try await firebaseAuthManager.signUp(email: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws {
        try await firebaseAuthManager.signIn(email: email, password: password)

    }

    
    func signOut() throws{
       try firebaseAuthManager.signOut()
    }
    
    func resetPassword(email: String) async throws{
      try await firebaseAuthManager.resetPassword(email: email)
    }
    

    
   
    
    private var firebaseAuthManager = FirebaseAuthManager()
    
}
