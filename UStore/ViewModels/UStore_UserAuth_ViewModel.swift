//
//  UStore_UserAuth_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation
import FirebaseAuth

class UStore_UserAuth_ViewModel : ObservableObject{
    private var repo : UStore_RepositoryImpl
    @Published var authForm : AuthForme
    
    init() {
        repo = UStore_RepositoryImpl()
        authForm = AuthForme()
    }
    
    var userIsLogin: Bool {
        return repo.userIsLogin
    }
    
    func signUp(email : String  , password : String ){
        repo.signUp(email:email, password: password)
    }
    
    func signIn(email : String  , password : String ){
        repo.signIn(email: email, password: password)
    }
    
    func signOut(){
        repo.signOut()
    }
    
    
    
    func handleLoginWithGoogle(){
        
    }
    
    
    func handleLoginWithFacebook(){
        
    }
    
    func handelSignIn() {
        if authForm.email.isEmpty || authForm.password.isEmpty {
            authForm.alertMessage = "Please fill in all fields."
            authForm.showAlert = true
            return
        }
        
        signIn(email: authForm.email, password: authForm.password)
        if !repo.authCallback.isSignIn {
            authForm.alertMessage = AuthError.failedSignIn.localizedDescription
            authForm.showAlert = true
            return
            
        } else{
            authForm.isLoading = true
            authForm.navigateToView = true
            authForm.isLoading = false
        }
    }
    
    
    func handelresetPassword() {
        if authForm.email.isEmpty  {
            authForm.alertMessage = "Please fill in all fields."
            authForm.showAlert = true
            return
        }
        
        signIn(email: authForm.email, password: authForm.password)
        if !repo.authCallback.isSignIn {
            authForm.alertMessage = AuthError.failedSignIn.localizedDescription
            authForm.showAlert = true
            return
            
        } else{
            authForm.isLoading = true
            authForm.navigateToView = true
            authForm.isLoading = false
        }
    }
    
    func handleSignUp(){
        // Check if any field is empty
        if authForm.email.isEmpty || authForm.password.isEmpty || authForm.confirmPassword.isEmpty {
            authForm.alertMessage = "Please fill in all fields."
            authForm.showAlert = true
            return
        }
        
        // Check if the email format is valid
        if !isValidEmail(authForm.email) {
            authForm.alertMessage = "Please enter a valid email address."
            authForm.showAlert = true
            return
        }
        
        // Check for password strength
        if let errorMessage = validatePassword(authForm.password) {
            authForm.alertMessage = errorMessage
            authForm.showAlert = true
            return
        }
        
        // Check if passwords match
        if authForm.password != authForm.confirmPassword {
            authForm.alertMessage = "Passwords do not match. Please try again."
            authForm.showAlert = true
            return
        }
        
        // Ensure terms and conditions are accepted
        if !authForm.isTermsAccepted {
            authForm.alertMessage = "You must accept the terms and conditions to sign up."
            authForm.showAlert = true
            return
        }
        
        authForm.isLoading = true
        signUp(email: authForm.email, password: authForm.password)
        if repo.authCallback.isSignUp{
            authForm.alertMessage = AuthError.failedSignUp.localizedDescription
            authForm.showAlert = true
            return
        }else{
            authForm.isLoading = false
            authForm.navigateToView = true
        }
        
        
    }
    
    
    
    func handleResetPassword(email: String) {
        if isValidEmail(email) {
            repo.resetPassword(email: email)
            authForm.alertMessage = "Email is sent successfully"
            authForm.showAlert = true
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

