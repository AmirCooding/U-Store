//
//  AuthCallback.swift
//  UStore
//
//  Created by Amir Lotfi on 08.09.24.
//

import Foundation

struct AuthCallback{
    internal init(isSignUp: Bool = false, isSignIn: Bool = false, isSignOut: Bool = false, isUserCreated: Bool = false, isUserfetched: Bool = false) {
        self.isSignUp = isSignUp
        self.isSignIn = isSignIn
        self.isSignOut = isSignOut
        self.isUserCreated = isUserCreated
        self.isUserfetched = isUserfetched
    }
    
    var isSignUp : Bool = false
    var isSignIn : Bool = false
    var isSignOut : Bool = false
    var isUserCreated : Bool = false
    var isUserfetched : Bool = false
}
