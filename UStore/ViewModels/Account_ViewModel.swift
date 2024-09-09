//
//  Account_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation

class Account_ViewModel : ObservableObject {
    private var repo : UStore_RepositoryImpl
    @Published var authForm : AuthForme
    
    init() {
        self.repo = UStore_RepositoryImpl()
        authForm = AuthForme()
    }
    
    
    func handelSignOut() throws{
       try repo.signOut()
        authForm.navigateToView = true
    }
    
    
    
    
}
