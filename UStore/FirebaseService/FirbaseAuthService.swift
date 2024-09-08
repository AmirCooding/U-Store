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

class FirbaseAuth {
    var user: User?
    var userAuth: UserAuth?
    var authCallback : AuthCallback
    
    init(){
        authCallback = AuthCallback()
    }
    
    private(set) var error: String = ""
    
    var userIsLogin: Bool {
        user != nil
    }
    
    func createUser(id: String, email: String) {
        let user = UserAuth(id: id, email: email)
        do {
            try Firestore.firestore().collection("users").document(id).setData(from: user)
            self.authCallback.isUserCreated = true
            print("User created successfully!")
            error = ""
        } catch {
            self.error = AuthError.failedCreatingUser.localizedDescription
            self.authCallback.isUserCreated = false
            print("Error creating user: \(error)")
        }
    }
    
    func getUser(id: String) {
        Firestore.firestore().collection("users").document(id).getDocument { document, error in
            if let error = error {
                self.error = AuthError.failedFetchUser.localizedDescription
                print("\(self.error): \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists else {
                self.error = AuthError.failedFetchUser.localizedDescription
                print("\(self.error): Document with id: \(id) not found")
                return
            }
            do {
                let userAuth = try document.data(as: UserAuth.self)
                self.userAuth = userAuth
                print("User is fetched successfully!")
                self.authCallback.isUserfetched = true
                self.error = ""
            } catch {
                self.error = AuthError.failedFetchUser.localizedDescription
                self.authCallback.isUserfetched = false
                print("\(self.error): \(error.localizedDescription)")
            }
        }
    }
    
    func signUp(username: String, password: String) {
        auth.createUser(withEmail: username, password: password) { authResult, error in
            if let error = error {
                self.error = AuthError.failedSignUp.localizedDescription
                print("\(self.error): \(error.localizedDescription)")
                return
            }
            guard let authResult = authResult, let email = authResult.user.email else {
                self.error = AuthError.failedSignUp.localizedDescription
                self.authCallback.isSignUp = false
                print("\(self.error): Cannot access authResult")
                return
            }
            self.authCallback.isSignUp = true
            print("User with email '\(email)' is registered with id '\(authResult.user.uid)'")
            self.createUser(id: authResult.user.uid, email: email)
            self.signIn(username: username, password: password)
        }
    }
    
    func signIn(username: String, password: String) {
        auth.signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                self.error = AuthError.failedSignIn.localizedDescription
                self.authCallback.isSignIn = false
                print("\(self.error): \(error.localizedDescription)")
                return
            }
            guard let authResult = authResult, let email = authResult.user.email else {
                self.authCallback.isSignIn = false
                self.error = AuthError.failedSignIn.localizedDescription
                print("\(self.error): Cannot access authResult")
                return
            }
            self.authCallback.isSignIn = true
            print("User with email '\(email)' is signed in with id '\(authResult.user.uid)'")
            self.user = authResult.user
            self.getUser(id: authResult.user.uid)
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
            self.authCallback.isSignOut = true
            print("User sign out succeeded!")
            error = ""
        } catch {
            self.error = AuthError.failedSignOut.localizedDescription
            print("\(self.error): \(error.localizedDescription)")
        }
    }
    
    func resetPassword(email : String) {
        do {
            try auth.sendPasswordReset(withEmail: email)
            self.user = nil
            self.authCallback.isSignOut = true
            print("User sign out succeeded!")
            error = ""
        } catch {
            self.error = AuthError.failedSignOut.localizedDescription
            print("\(self.error): \(error.localizedDescription)")
        }
    }
    
    
  
    
    func checkAuth() {
        guard let currentUser = auth.currentUser else {
            return
        }
        self.user = currentUser
        getUser(id: currentUser.uid)
    }

    private var auth = Auth.auth()
}

