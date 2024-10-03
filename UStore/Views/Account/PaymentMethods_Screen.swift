//
//  PaymentMethods_Screen().swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//

import SwiftUI

struct PaymentMethods_Screen: View {
    @EnvironmentObject var viewModel: Account_ViewModel
    @State private var selectedPaymentMethod: String = ""
    @State private var showEmailField = false
    @State private var showCardInfoField = false
    @State private var showIbanField = false

    var body: some View {
        NavigationView {
            ScrollView {
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
                    
                    // Payment Options
                    PaymentOptionView(
                        selectedPaymentMethod: $selectedPaymentMethod,
                        showField: $showEmailField,
                        methodName: "PayPal",
                        logoName: Image("paypal_logo"),
                        width: 30,
                        height: 30
                    )
                    
                    PaymentOptionView(
                        selectedPaymentMethod: $selectedPaymentMethod,
                        showField: $showCardInfoField,
                        methodName: "Credit/Debit Card",
                        logoName: Image("card_logo 1"),
                        width: .infinity,
                        height: 30
                    )
                    
                    PaymentOptionView(
                        selectedPaymentMethod: $selectedPaymentMethod,
                        showField: $showIbanField,
                        methodName: "SEPA Direct Debit",
                        logoName: Image("sepa_logo"),
                        width: 50,
                        height: 30
                    )
                    
                    Spacer()
                }
                .onAppear {
                    selectedPaymentMethod = viewModel.updateSelectedPaymentMethod()
                }
                .padding()
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct PaymentOptionView: View {
    @EnvironmentObject var viewModel: Account_ViewModel
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
                Task {
                    do {
                        try await viewModel.updateUserProfile(profile: viewModel.profile)
                        
                    } catch {
                        print("Failed to update user profile: \(error)")
                    }
                }
            }
            
            if showField {
                switch methodName {
                case "PayPal":
                    CustomTextField(
                        text: Binding(
                            get: { viewModel.profile.paymentMethode.payPal.email },
                            set: { newValue in
                                viewModel.profile.paymentMethode.payPal.email = newValue
                                viewModel.profile.paymentMethode.payPal.payPalisClicked = true
                                viewModel.profile.paymentMethode.creditCard.creditCartIssClicked = false
                                viewModel.profile.paymentMethode.sepa.sepaClicked = false
                            }
                        ),
                        placeholder: "Enter your PayPal Email",
                        title: "Email Address",
                        iconBefor: "envelope",
                        iconAfter: nil,
                        showIcon: false,
                        isSecure: false
                    )
                    
                case "Credit/Debit Card":
                    CustomTextField(
                        text: Binding(
                            get: { viewModel.profile.paymentMethode.creditCard.creaditNumber },
                            set: { newValue in
                                // Remove all non-numeric characters
                                let cleanedInput = newValue.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                                
                                // Limit to 16 digits and format with spaces
                                if cleanedInput.count <= 16 {
                                    let formatted = viewModel.formatCardNumber(cleanedInput)
                                    viewModel.profile.paymentMethode.creditCard.creaditNumber = formatted
                                }
                                
                                viewModel.profile.paymentMethode.payPal.payPalisClicked = false
                                viewModel.profile.paymentMethode.creditCard.creditCartIssClicked = true
                                viewModel.profile.paymentMethode.sepa.sepaClicked = false
                            }
                        ),
                        placeholder: "Enter Card Number",
                        title: "Card Number",
                        iconBefor: nil,
                        showIcon: false,
                        isSecure: false
                    )
                    
                    CustomTextField(
                        text: Binding(
                            get: { viewModel.profile.paymentMethode.creditCard.expiryDate },
                            set: { newValue in
                                let cleanedInput = newValue.replacingOccurrences(of: "[^0-9/]", with: "", options: .regularExpression)
                                if cleanedInput.count <= 5 {
                                    viewModel.profile.paymentMethode.creditCard.expiryDate = cleanedInput
                                }
                            }
                        ),
                        placeholder: "MM/YY",
                        title: "Expiry Date",
                        iconBefor: nil,
                        showIcon: false,
                        isSecure: false
                    )
                    
                    CustomTextField(
                        text: Binding(
                            get: { viewModel.profile.paymentMethode.creditCard.cvv },
                            set: { newValue in
                                let cleanedInput = newValue.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                                if cleanedInput.count <= 4 {
                                    viewModel.profile.paymentMethode.creditCard.cvv = cleanedInput
                                }
                            }
                        ),
                        placeholder: "Enter CVV",
                        title: "CVV",
                        iconBefor: nil,
                        showIcon: false,
                        isSecure: true
                    )
                    
                case "SEPA Direct Debit":
                    CustomTextField(
                        text: Binding(
                            get: { viewModel.profile.paymentMethode.sepa.iban },
                            set: { newValue in
                                // Allow only alphanumeric characters
                                let cleanedInput = newValue.replacingOccurrences(of: "[^A-Za-z0-9]", with: "", options: .regularExpression)
                                if cleanedInput.count <= 22 {
                                    viewModel.profile.paymentMethode.sepa.iban = cleanedInput
                                }
                            }
                        ),
                        placeholder: "Enter IBAN",
                        title: "IBAN",
                        iconBefor: nil,
                        showIcon: false,
                        isSecure: false
                    )
                    
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
        .environmentObject(Account_ViewModel())
}
