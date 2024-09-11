//
//  FirbaseAuthService.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseAuth
import GoogleSignIn

class FAuthManager {
    var user: User?
    var userAuth: User?
    static let shared = FAuthManager()
    private(set) var error: String = ""

    
    var isUserSignedIn: Bool {
        return user != nil
    }
    
  
    
    func signUp(email: String, password: String) async throws {
        let authResult = try await auth.createUser(withEmail: email, password: password)
        guard let email = authResult.user.email else {
            throw AuthError.inValidEmail
        }
        print("User with email '\(email)' is registered with id '\(authResult.user.uid)'")
        try await self.signIn(email: email, password: password)
        FFUserManager.shared.createUser(id: authResult.user.uid, email: email)
    
    }
    
    
    
    func signIn(email: String, password: String) async throws {
        let authResult = try await auth.signIn(withEmail: email, password: password)
        guard let email = authResult.user.email else {
            throw AuthError.inValidEmail
        }
        self.user = authResult.user
        FFUserManager.shared.fetchUser(id: authResult.user.uid) 
        print("User signed in successfully with \(email)")
    }

    
    
    func signOut() throws {
        do {
            try auth.signOut()
            self.user = nil
            print("User sign out succeeded!")
            error = ""
        } catch {
            self.error = AuthError.failedSignOut.localizedDescription
            print("\(self.error): \(error.localizedDescription)")
        }
    }
    
    
    func resetPassword(email: String) async throws {
        do {
            try await auth.sendPasswordReset(withEmail: email)
        } catch {
            self.error = "Cannot reset password"
            print("\(self.error): \(error.localizedDescription)")
        }
    }
    
    
    func checkAuth() {
        guard let currentUser = auth.currentUser else {
            return
        }
        self.user = currentUser
        FFUserManager.shared.fetchUser(id: currentUser.uid)
    }
    
    private var auth = Auth.auth()
    
    
    func SigninWithGoogle() async throws {
        guard let topVC =  await Utilities.shared.topViewController() else{
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        let accessToken : String = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await FAuthManager.shared.signInWithGoogle(tokens: tokens)
    }
    
}


// MARK : SIGN IN SSO

extension FAuthManager{
    func signIn(credential : AuthCredential) async throws{
        do{
            try await auth.signIn(with: credential)
        }catch{
            self.error = AuthError.faildSignInWithGoogle.localizedDescription
            print("\(self.error): \(error.localizedDescription)")
        }
        
    }
    
    
    func signInWithGoogle(tokens : GoogleSignInResultModel) async throws{
        let credential = GoogleAuthProvider.credential(withIDToken:tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
}
