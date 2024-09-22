//
//  Account_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation
import Combine
import SwiftUI
import os

class Account_ViewModel : ObservableObject {
    private var repos : UStore_RepositoryImpl
    @Published var authForm : AuthForme
    @Published var profile = UserProfile(){
        didSet{
            Task{
                try await fetchUserProfile()
            }
        }
    }
  
    var scriptions = Set<AnyCancellable>()

    
    init() {
        repos = UStore_RepositoryImpl()
        authForm = AuthForme()
        repos.userProfile.assign(to: \.profile , on: self).store(in: &scriptions)
    
    }
    
    
    func updateUserProfile(profile : UserProfile, image: UIImage?) async throws {
    
        do{
            try await repos.updateUserProfile(profile: profile, image: image)
        }catch{
            LoggerManager.logMessageAndError("Can  not Update Profile Details ", error: HttpError.requestFailed)
        }
    }
    
    func fetchUserProfile() async throws {
        do{
            try await repos.fetchUserProfile()
        }catch{
            LoggerManager.logMessageAndError("Can  not fetch Profile Details ", error: HttpError.requestFailed)

        }
       
    }
    
    func deleteUserProfile() async throws {
        do{
           try await repos.deleteUserProfile()
        }catch{
            LoggerManager.logMessageAndError("Can  not delete Profile Details ", error: HttpError.requestFailed)

        }
    }
    
    func handelSignOut() throws{
       try repos.signOut()
        repos.removeCartListener()
        repos.removeFavoriteListener()
        repos.removeProfileListener()
        authForm.navigateToView = true
    }
    
    
    
    
}
