//
//  SigninWithGoogle.swift
//  UStore
//
//  Created by Amir Lotfi on 08.09.24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth




struct GoogleSignInResultModel{
    let idToken : String
    let accessToken : String
}
