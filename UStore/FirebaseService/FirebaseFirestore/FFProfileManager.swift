//
//  FFProfileManager.swift
//  UStore
//
//  Created by Amir Lotfi on 19.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import Combine

class FFUserProfileManager {
    static let shared = FFUserProfileManager()
    @Published var userProfile: UserProfile
    private let dbCollection = Firestore.firestore().collection("profile")
    private let storage = Storage.storage()
    private let subject = PassthroughSubject<UserProfile, Never>()
    private var listener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization -
   
    private init() {
        userProfile = UserProfile()
        guard let userId =  Auth.auth().currentUser?.uid else {
            print("No valid user ID")
            return
        }
        listener = dbCollection.document(userId).addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error listening to Firestore: \(error)")
                return
            }
            guard let snapshot = snapshot else {
                print("No snapshot available")
                return
            }
            
            let updatedProfile = try? snapshot.data(as: UserProfile.self)
            
            print("Fetched user profile from snapshot listener")
            if let userProfile  = updatedProfile{
            self.subject.send(userProfile)
            }
            
        }
        
        
        subject.sink { profile in
            self.userProfile = profile
        }.store(in: &cancellables)
    }
    
    
    // MARK: - Create new user profile -
   
    func createUserProfile(profile: UserProfile  , image : Data?) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {print("Invalid User ID or Email")
            return }
        var imageUrl: String? = nil
        if let image = image {
            do {
                imageUrl = try await StorageManager.shared.saveImage(data: image)
            } catch {
                print("Failed to upload image: \(error.localizedDescription)")
                throw error
            }
        }
        let profile = UserProfile(userId: userId, fullName: profile.fullName, email: profile.email, tel: profile.tel , imagePath:  imageUrl , userAddress: profile.userAddress)
          try  dbCollection.document(userId).setData(from : profile)
     
    }

   
    // MARK: - fetch  user profile -
   
    func fetchUserProfile() async throws -> UserProfile {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No valid user ID to create favorite")
            throw AuthError.invalidUser
        }
        let document = try await dbCollection.document(userId).getDocument()
        
        if let userProfile = try? document.data(as: UserProfile.self) {
            DispatchQueue.main.async {
                self.userProfile = userProfile
                LoggerManager.logMessageAndError(userProfile.fullName, error: HttpError.unknownError)
            }
        } else {
            print("Failed to decode user profile")
        }
        return userProfile
    }
  
    
    // MARK: - Update  user profile -
  
    func updateUserProfile(profile: UserProfile ) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No valid user ID to create favorite")
            return
        }
        _ = dbCollection.document(profile.userId)
        let updatedProfile = profile
        try  dbCollection.document(userId).setData(from :  updatedProfile)
        try await fetchUserProfile()
    }
    
   
    // MARK: - delete  user profile -
    
    func deleteUserProfile() async throws {
        let userId =  Auth.auth().currentUser?.uid
        let docRef = dbCollection.document( userId ?? "NO User ID")
        try await docRef.delete()
        let storageRef = storage.reference().child("profileImages/\(String(describing: userId)).jpg")
        try await storageRef.delete()
    }
    
    
    // MARK: - Remove Listener -
    func removeProfileListener() {
       userProfile = UserProfile()
        listener?.remove()
        listener = nil
    }
}

