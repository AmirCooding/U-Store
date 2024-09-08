//
//  UStore_RepositoryImpl.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation


struct UStore_RepositoryImpl : UStore_Repository{

    var authCallback: AuthCallback
    
    init(){
        authCallback = AuthCallback()
    }
    
    func signUp(email: String, password: String) {
        firebaseAuth.signUp(username: email, password: password)
    }
    
    func signIn(email: String, password: String) {
        firebaseAuth.signIn(username: email, password: password)
    }
    
    func signOut() {
        
        firebaseAuth.signOut()
    }
    
    func resetPassword(email: String) {
        firebaseAuth.resetPassword(email: email)
    }
    
    
    var userIsLogin: Bool {
          firebaseAuth.userIsLogin
      }
    
    
   
    
    private var firebaseAuth = FirbaseAuth()
    
}
