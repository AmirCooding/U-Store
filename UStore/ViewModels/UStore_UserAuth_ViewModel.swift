//
//  UStore_UserAuth_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation
import FirebaseAuth
import GoogleSignInSwift
import GoogleSignIn

class UStore_UserAuth_ViewModel : ObservableObject{
    var repo : UStore_RepositoryImpl
    @Published var selectedImage: UIImage? = nil
    @Published var authForm : AuthForme
    @Published var profile : UserProfile
    var email: String {
        get {
            return authForm.email
        }
        set {
            authForm.email = newValue
            profile.email = newValue
        }
    }

    
    init() {
        repo = UStore_RepositoryImpl()
        authForm = AuthForme()
        profile = UserProfile()
    }
    
    var userIsLogin: Bool {
        return repo.userIsLogin
    }

    
    func handleLoginWithGoogle() async throws {
        do {
            try await repo.signInWithGoogle()
            DispatchQueue.main.async {
                self.authForm.isLoading = true
                self.authForm.navigateToView = true
                self.authForm.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.authForm.alertMessage = AuthError.faildSignInWithGoogle.localizedDescription
                self.authForm.showAlert = true
            }
          
        }
    }

    
    func handleLoginWithFacebook(){
        
    }
    
    func handelSignIn() async throws {
        do {
            try await repo.signIn(email: authForm.email, password: authForm.password)
            DispatchQueue.main.async {
                self.authForm.isLoading = true
                self.authForm.navigateToView = true
                self.authForm.isLoading = false
            }
            
        } catch {
            DispatchQueue.main.async {
                self.authForm.alertMessage = AuthError.failedSignIn.localizedDescription
                self.authForm.showAlert = true
            }
        }
    }

    
    func handleSignUp() async throws {
        if authForm.email.isEmpty || authForm.password.isEmpty || authForm.confirmPassword.isEmpty {
            DispatchQueue.main.async {
                self.authForm.alertMessage = "Please fill in all fields."
                self.authForm.showAlert = true
            }
            return
        }
        
        if !isValidEmail(authForm.email) {
            DispatchQueue.main.async {
                self.authForm.alertMessage = "Please enter a valid email address."
                self.authForm.showAlert = true
            }
            return
        }
        if let errorMessage = validatePassword(authForm.password) {
            DispatchQueue.main.async {
                self.authForm.alertMessage = errorMessage
                self.authForm.showAlert = true
            }
            return
        }
        if authForm.password != authForm.confirmPassword {
            DispatchQueue.main.async {
                self.authForm.alertMessage = "Passwords do not match. Please try again."
                self.authForm.showAlert = true
            }
            return
        }
        
        // Ensure terms and conditions are accepted
        if !authForm.isTermsAccepted {
            DispatchQueue.main.async {
                self.authForm.alertMessage = "You must accept the terms and conditions to sign up."
                self.authForm.showAlert = true
            }
            return
        }
        do {
            try await repo.signUp(email: authForm.email, password: authForm.password)
            guard let userId = Auth.auth().currentUser?.uid else {
                throw AuthError.failedSignUp
            }
            var profile = profile
            profile.userId = userId
            try await repo.createUserProfile(profile: profile, image: selectedImage)
            DispatchQueue.main.async {
                self.authForm.isLoading = true
                self.authForm.navigateToView = true
                self.authForm.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.authForm.alertMessage = AuthError.failedSignUp.localizedDescription
                self.authForm.showAlert = true
            }
            return
        }

    }

    
    
    
    func handleResetPassword(email: String) async throws {
        if isValidEmail(email) {
         try await  repo.resetPassword(email: email)
            authForm.navigateToView = true
        } else {
            authForm.alertMessage = AuthError.inValidEmail.localizedDescription
            authForm.showAlert = true
           
            return
        }
    }
    
    
    
    
    // Validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    
    // Validate password strength
    private func validatePassword(_ password: String) -> String? {
        if password.count < 8 {
            return "Password must be at least 8 characters long."
        }
        let uppercaseRange = password.rangeOfCharacter(from: .uppercaseLetters)
        if uppercaseRange == nil {
            return "Password must contain at least one uppercase letter."
        }
        let lowercaseRange = password.rangeOfCharacter(from: .lowercaseLetters)
        if lowercaseRange == nil {
            return "Password must contain at least one lowercase letter."
        }
        let digitRange = password.rangeOfCharacter(from: .decimalDigits)
        if digitRange == nil {
            return "Password must contain at least one number."
        }
        let specialCharacterRange = password.rangeOfCharacter(from: CharacterSet.punctuationCharacters)
        if specialCharacterRange == nil {
            return "Password must contain at least one special character."
        }
        return nil
    }
    
}

