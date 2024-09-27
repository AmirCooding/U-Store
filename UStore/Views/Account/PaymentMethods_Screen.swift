//
//  PaymentMethods_Screen().swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//

import SwiftUI


struct PaymentMethods_Screen: View {
    @State private var selectedPaymentMethod = "PayPal"
    @State private var showEmailField = false
    @State private var showCardInfoField = false
    @State private var showIbanField = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
             
                VStack(alignment: .leading, spacing: 5) {
                    Text("Payment Method")
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.bottom, 30)
    
                VStack(alignment: .leading, spacing: 5) {
                    Text("Do you have a voucher?")
                        .font(.headline)
                    
                    Text("Vouchers can be applied in the next step.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 30)
                
          
                Text("Select Payment Method")
                    .font(.headline)
                
                PaymentOptionView(selectedPaymentMethod: $selectedPaymentMethod,
                                  showField: $showEmailField,
                                  methodName: "PayPal",
                                  logoName: Image("paypal_logo"),
                                  width: 30,
                                  height: 30)
                
                PaymentOptionView(selectedPaymentMethod: $selectedPaymentMethod,
                                  showField: $showCardInfoField,
                                  methodName: "Credit/Debit Card",
                                  logoName: Image("card_logo 1"),
                                  width: .infinity,
                                  height: 30)
                
                PaymentOptionView(selectedPaymentMethod: $selectedPaymentMethod,
                                  showField: $showIbanField,
                                  methodName: "SEPA Direct Debit",
                                  logoName: Image("sepa_logo"),
                                  width: 50,
                                  height: 30)
                
                Spacer()
                
                CustomButton(text: "Continue", textColor: Colors.white.color(), backgroundColor: Colors.primary.color(), action: {})
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct PaymentOptionView: View {
    @Binding var selectedPaymentMethod: String
    @Binding var showField: Bool
    var methodName: String
    var logoName: Image
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                RadioButton(isSelected: selectedPaymentMethod == methodName)
                
                Text(methodName)
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Spacer()
                
                logoName
                    .resizable()
                    .frame(width: width, height: height)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .onTapGesture {
                selectedPaymentMethod = methodName
                showField.toggle()
            }
            
            
            if showField {
                switch methodName {
                case "PayPal":
                    TextField("Enter your email", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 10)
                case "Credit/Debit Card":
                    TextField("Card Number", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 10)
                    TextField("Expiry Date", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)
                    TextField("CVV", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 5)
                case "SEPA Direct Debit":
                    TextField("IBAN", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top, 10)
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct RadioButton: View {
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? Colors.primary.color() : Color.gray, lineWidth: 2)
                .frame(width: 20, height: 20)
            
            if isSelected {
                Circle()
                    .fill(Colors.primary.color())
                    .frame(width: 10, height: 10)
            }
        }
    }
}



#Preview {
    PaymentMethods_Screen()
}
