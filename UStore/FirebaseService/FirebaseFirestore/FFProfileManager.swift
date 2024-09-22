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
    @Published var userProfile: UserProfile?
    private let dbCollection = Firestore.firestore().collection("profile")
    private let storage = Storage.storage()
    private let subject = PassthroughSubject<UserProfile?, Never>()
    private var listener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
   // private let userId = FFUserManager.shared.auth.currentUser?.uid
   // private let userId = FFUserManager.shared.appUser?.id
    
    // MARK: - Initialization -
    private init() {
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
            self.subject.send(updatedProfile)
        }
        
        
        subject.sink { profile in
            self.userProfile = profile
        }.store(in: &cancellables)
    }
    
    
    // MARK: - Create new user profile -
    func createUserProfile(profile: UserProfile, image: UIImage?) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {print("Invalid User ID or Email")
            return }
        var imageUrl: String? = nil
        if let image = image {
            do {
                imageUrl = try await uploadImage(userId: userId, image: image)
            } catch {
                print("Failed to upload image: \(error.localizedDescription)")
                throw error
            }
        }
        let profile = UserProfile(userId: userId, fullName: profile.fullName, email: profile.email, tel: profile.tel, image: imageUrl)
          try  dbCollection.document(userId).setData(from : profile)
          // try dbCollection.addDocument(from: profile)
    }

    
    //MARK: - Upload Image to Firebase Storage and get URL -
    
    private func uploadImage(userId: String, image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "ImageError", code: -1, userInfo: nil)
        }
        let storageRef = storage.reference().child("profileImages/\(userId).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = try await storageRef.putDataAsync(imageData, metadata: metadata)
        
        let url = try await storageRef.downloadURL()
        return url.absoluteString
    }
    
    // MARK: - fetch  user profile -
    func fetchUserProfile() async throws{
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No valid user ID to create favorite")
            return
        }
        let document = try await dbCollection.document(userId).getDocument()
        self.userProfile = try document.data(as: UserProfile.self)
        
    }
    
    // MARK: - Update  user profile -
  
    func updateUserProfile(profile: UserProfile, image: UIImage?) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No valid user ID to create favorite")
            return
        }
        let docRef = dbCollection.document(profile.userId)
        var updatedProfile = profile
        if let image = image {
            let imageUrl = try await uploadImage(userId: profile.userId, image: image)
            updatedProfile.image = imageUrl
        }
        try  dbCollection.document(userId).setData(from :  profile)
    }
   
    // MARK: - delete  user profile -
    func deleteUserProfile() async throws {
        let userId =  Auth.auth().currentUser?.uid
        let docRef = dbCollection.document( userId ?? "NO User ID")
        try await docRef.delete()
        let storageRef = storage.reference().child("profileImages/\(String(describing: userId)).jpg")
        try await storageRef.delete()
    }
    
    
    // MARK: - Remove Listener
    func removeProfileListener() {
        userProfile = nil
        listener?.remove()
        listener = nil
    }
}

