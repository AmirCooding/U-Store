//
//  AuthError.swift
//  UStore
//
//  Created by Amir Lotfi on 08.09.24.
//

enum AuthError: Error {
    case failedCreatingUser
    case failedFetchUser
    case failedSignUp
    case failedSignIn
    case failedSignOut
    case inValidEmail
    
    var localizedDescription: String {
        switch self {
        case .failedCreatingUser:
            return "Error creating user."
        case .failedFetchUser:
            return "Failed to fetch user."
        case .failedSignUp:
            return "Sign-up process failed."
        case .failedSignIn:
            return "Sign-in failed. Please try again."
        case .failedSignOut:
            return "Sign-out process failed."
        case .inValidEmail:
            return "  Invalid email format"
            
          
        }
    }
}

