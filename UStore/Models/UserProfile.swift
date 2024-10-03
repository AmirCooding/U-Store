//
//  UserProfile.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//


import Foundation
import FirebaseFirestore

struct UserProfile: Codable, Identifiable {
    internal init(id: String? = nil, userId: String = "", fullName: String = "", email: String = "", tel: String = "", imagePath: String? = nil, userAddress: UserAddress = UserAddress(street: "", number: "" , state: "" , zipCode: "" , country: ""), paymentMethode: PaymentMethod = PaymentMethod(payPal: PayPal(payPalisClicked: false , email:  ""), creditCard: CreditCard(creditCartIssClicked: false, cvv: ""), sepa: Sepa(sepaClicked: false , iban: " "))) {
        self.id = id
        self.userId = userId
        self.fullName = fullName
        self.email = email
        self.tel = tel
        self.imagePath = imagePath
        self.userAddress = userAddress
        self.paymentMethode = paymentMethode
    }
    
    
  
    @DocumentID var id: String?
    var userId: String = ""
    var fullName: String = ""
    var email: String = ""
    var tel: String = ""
    var imagePath: String?
    var userAddress: UserAddress = UserAddress(street: "", number: "" , state: "" , zipCode: "" , country: "")
    var paymentMethode : PaymentMethod = PaymentMethod(payPal: PayPal(payPalisClicked: false , email:  ""), creditCard: CreditCard(creditCartIssClicked: false, cvv: ""), sepa: Sepa(sepaClicked: false , iban: " "))
}




