//
//  Account_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 09.09.24.
//

import Foundation
import Combine
import SwiftUI
import os
@MainActor
 class Account_ViewModel : ObservableObject {
    private var repos : UStore_RepositoryImpl
    @Published var imageData: Data?
    @Published var authForm : AuthForme
    @Published var profile = UserProfile()
    @Published var cartProducts: [Product] = []
    @Published var selectedPaymentMethod: String = ""
    var scriptions = Set<AnyCancellable>()
    
    
    
    init() {
        repos = UStore_RepositoryImpl()
     
        authForm = AuthForme()
        repos.userProfile
            .receive(on: DispatchQueue.main)
            .assign(to: \.profile, on: self)
            .store(in: &scriptions)
        Task{
             try await fetchUserProfile()
       
        }
     
    }
     

     // MARK: - Selected Payment Method -
     func updateSelectedPaymentMethod() -> String {
         
         if profile.paymentMethode.payPal.payPalisClicked == true{
             selectedPaymentMethod = "PayPal"
         }
         if profile.paymentMethode.creditCard.creditCartIssClicked == true {
             selectedPaymentMethod = "Credit/Debit Card"
         }
         if profile.paymentMethode.sepa.sepaClicked == true {
             selectedPaymentMethod = "SEPA Direct Debit"
         }
         return self.selectedPaymentMethod
        }
    
     // MARK: - Update Profile And fetch Data-
     func updateProfileAndFetchData() async throws {
         try await fetchUserProfile()
         try await fetchImageProfile()
     }
     // MARK: - Update user profile -
     func updateUserProfile(profile: UserProfile) async throws {
         do {
             try await repos.updateUserProfile(profile: profile)
             try await updateProfileAndFetchData()
         } catch {
             LoggerManager.logMessageAndError("Cannot update Profile Details", error: HttpError.requestFailed)
         }
     }

     // MARK: - Fetch Image Profile -
    func fetchImageProfile() async throws {
        guard let imagePath = profile.imagePath else {
            print("NOT accessable Image")
            return
        }
        
        do {
            let data = try await repos.fetchImage(path: imagePath)
            DispatchQueue.main.async {
                self.imageData = data
            }
        } catch {
            print("Fehler beim Laden des Bildes: \(error)")
        }
    }
     // MARK: - Fetch User Profile -
    func fetchUserProfile() async throws {
        do{
         try await repos.fetchUserProfile()
        }catch{
            LoggerManager.logMessageAndError("Can  not fetch Profile Details ", error: HttpError.requestFailed)
            
        }
        
    }
     // MARK: - Delete User Profile -
    func deleteUserProfile() async throws {
        do{
            try await repos.deleteUserProfile()
        }catch{
            LoggerManager.logMessageAndError("Can  not delete Profile Details ", error: HttpError.requestFailed)
            
        }
    }
    
     // MARK: - Remove Listener and Signout -
    func handelSignOut() throws{
        repos.removeCartListener()
        repos.removeFavoriteListener()
        repos.removeProfileListener()
        try repos.signOut()
        authForm.navigateToView = true
    }
     // MARK: - Format Cart Number-
    
        func formatCardNumber(_ number: String) -> String {
           let components = number.compactMap { String($0) }
           var formattedNumber = ""
           
           for (index, digit) in components.enumerated() {
               if index > 0 && index % 4 == 0 {
                   formattedNumber += " "
               }
               formattedNumber += digit
           }
           
           return formattedNumber
       }
   }

     // MARK: - Format Expirey Date -
    
     func formatExpiryDate(_ expiryDate: String) -> String {
         let cleanedDate = expiryDate.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
         if cleanedDate.count <= 2 {
             return cleanedDate
         }
         let month = String(cleanedDate.prefix(2))
         let year = String(cleanedDate.dropFirst(2).prefix(2))
         
         return month + "/" + year
     }
     
     // MARK: - Format Save IBAN -

     func formatIBAN(_ iban: String) -> String {
         let cleanedIBAN = iban.replacingOccurrences(of: "[^A-Za-z0-9]", with: "", options: .regularExpression)
         guard cleanedIBAN.count > 6 else { return cleanedIBAN }
         let firstFour = String(cleanedIBAN.prefix(4))
         let lastTwo = String(cleanedIBAN.suffix(2))
         let maskedMiddle = String(repeating: "*", count: max(0, cleanedIBAN.count - 6))
         return firstFour + maskedMiddle + lastTwo
     }


