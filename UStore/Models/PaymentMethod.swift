//
//  PaymentMethod.swift
//  UStore
//
//  Created by Amir Lotfi on 26.09.24.
//

import Foundation


struct PaymentMethod  : Codable{
    var payPal : PayPal
    var creditCard : CreditCard
    var sepa : Sepa
}



struct PayPal : Codable {
    var payPalisClicked : Bool = false
    var email : String = ""
}


struct CreditCard : Codable {
    var creditCartIssClicked : Bool = false
    var cvv : String
    var creaditNumber : String  = ""
    var expiryDate : String  = ""
}


struct Sepa : Codable {
    var payPalisClicked : Bool = false
    var iban : String  = ""
}



