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
@MainActor
class Account_ViewModel : ObservableObject {
    private var repos : UStore_RepositoryImpl
    @Published var imageData: Data?
    @Published var authForm : AuthForme
    @Published var profile = UserProfile(){
        didSet{
            Task{
                try await fetchUserProfile()
                try await fetchImageProfile()
            }
        }
    }
    
    
    var scriptions = Set<AnyCancellable>()
    
    
    
    init() {
        repos = UStore_RepositoryImpl()
        authForm = AuthForme()
        repos.userProfile
            .receive(on: DispatchQueue.main)
            .assign(to: \.profile, on: self)
            .store(in: &scriptions)
    
        LoggerManager.logInfo(profile.fullName)
    }
    
    
    func updateUserProfile(profile : UserProfile) async throws {
        
        do{
            try await repos.updateUserProfile(profile: profile)
        }catch{
            LoggerManager.logMessageAndError("Can  not Update Profile Details ", error: HttpError.requestFailed)
        }
    }
    
    func fetchImageProfile() async throws {
        guard let imagePath = profile.imagePath else {
            print("NOT accessable Image")
            return
        }
        
        do {
            let data = try await repos.fetchImage(path: imagePath)
            DispatchQueue.main.async {
                self.imageData = data
            }
        } catch {
            print("Fehler beim Laden des Bildes: \(error)")
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
