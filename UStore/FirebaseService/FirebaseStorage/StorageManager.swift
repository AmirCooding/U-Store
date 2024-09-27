//
//  StorageManager.swift
//  UStore
//
//  Created by Amir Lotfi on 25.09.24.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

class StorageManager{
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    
    private var userId: String? {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No valid user ID to create Storage")
            return nil
        }
        return userId
    }
    func saveImage(data : Data) async throws ->  String {
        let  meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let path = "\(userId ?? "No valid user ID to create Storage").jpeg"
        let returnedMetaData = try await storage.child(path).putDataAsync(data ,metadata: meta)
        
        guard let returnedPath = returnedMetaData.path else{
            throw HttpError.requestFailed
        }
        
        return returnedPath
    }
    
    func fetchImage(imagePath: String) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            let storage = Storage.storage().reference(withPath: imagePath)
            let maxSize: Int64 = 5 * 1024 * 1024
            storage.getData(maxSize: maxSize) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: NSError(domain: "Unknown error", code: -1, userInfo: nil))
                }
            }
        }
    }

    
}
