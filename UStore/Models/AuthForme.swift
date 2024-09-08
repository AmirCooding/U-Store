//
//  SignUpForm.swift
//  UStore
//
//  Created by Amir Lotfi on 08.09.24.
//

import Foundation

struct AuthForme : Codable , Equatable{
    internal init(email: String = "", password: String = "", confirmPassword: String = "", showAlert: Bool = false, alertMessage: String = "", isLoading: Bool = false, navigateToView: Bool = false, isTermsAccepted: Bool = false) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.showAlert = showAlert
        self.alertMessage = alertMessage
        self.isLoading = isLoading
        self.navigateToView = navigateToView
        self.isTermsAccepted = isTermsAccepted
    }
    

       var email: String = ""
       var password: String = ""
       var confirmPassword: String = ""
       var showAlert: Bool = false
       var alertMessage: String = ""
       var isLoading: Bool = false
       var navigateToView: Bool = false
       var isTermsAccepted: Bool = false
}
