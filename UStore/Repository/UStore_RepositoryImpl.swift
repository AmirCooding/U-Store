//
//  UStore_RepositoryImpl.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation


struct UStore_RepositoryImpl : UStore_Repository{
    
    func signUp(email: String, password: String) {
        firebaseAuth.signUp(username: email, password: password)
    }
    
    func signIn(email: String, password: String) {
        firebaseAuth.signIn(username: email, password: password)
    }
    
    func signOut() {
        
        firebaseAuth.signOut()
    }
    
 
    

   
    
    
    private var firebaseAuth = FirbaseAuth()
    
}
