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
    case faildSignInWithGoogle
    
    var localizedDescription: String {
        switch self {
        case .failedCreatingUser:
            return "Error creating user."
        case .failedFetchUser:
            return "The email you entered does not exist. Please try again or create a new account if you haven't registered yet."
        case .failedSignUp:
            return "Sign-up process failed."
        case .failedSignIn:
            return "Failed to sign in Please check your Email or Password."
        case .failedSignOut:
            return "Sign-out process failed."
        case .inValidEmail:
            return "  Invalid email format"
        case .faildSignInWithGoogle:
            return "Faild Sign In With Google Account"
            
          
        }
    }
}

