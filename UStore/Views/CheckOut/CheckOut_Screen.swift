//
//  CheckOut_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 30.09.24.
//

import SwiftUI

struct CheckOut_Screen: View {
    @StateObject private var viewModel = CheckOut_ViewModel()
    @State private var isLoading: Bool = false
    @State private var showConfirmation: Bool = false
    @State private var navigateToHome: Bool = false
    @State private var isNavigating = false

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment : .leading){
                        HStack{
                            Text(String(viewModel.calculateAllProducts))
                                .bold()
                            Text("Products")
                                .foregroundColor(Colors.black.color())
                                .bold()
                        }.padding(.leading , 20)
                        Divider()
                        ForEach(Array(viewModel.cartProducts.enumerated()), id: \.element.id) { index, product in
                            CheckOutCard(product: product)
                                .environmentObject(viewModel).padding(.horizontal ,20)
                            if index < viewModel.cartProducts.count - 1 {
                                Divider()
                            }
                        }
                        
                        HStack{
                            Text("Estimated Delivery")
                                .foregroundColor(Colors.black.color())
                                .bold()
                        }.padding(.leading , 20)
                            .padding(.top ,20)
                        Divider()
                        
                        VStack(alignment : .leading){
                            HStack{
                                Image("delivery-truck")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                Text(viewModel.deliveryDate)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 14))
                            }.padding(.top, 10)
                                .padding(.leading, 20)
                            
                            HStack{
                                Image("truck_return")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                Text("Free Return")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 14))
                                Text("within 30 days from delivery date")
                                    .font(.system(size: 14))
                            }.padding(.top, 10)
                                .padding(.leading, 20)
                        }
                        
                        
                        
                        
                        HStack{
                            Text("Delivery Adress")
                                .foregroundColor(Colors.black.color())
                                .bold()
                        }.padding(.leading , 20)
                            .padding(.top ,20)
                        Divider()
                        
                        VStack(alignment : .leading){
                            Text(viewModel.profile.fullName)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.system(size: 16))
                                .foregroundColor(Colors.black.color())
                            
                            HStack{
                                
                                Text(viewModel.profile.userAddress.street)
                                    .font(GilroyFonts.font(style: .regular, size: 16))
                                    .foregroundColor(Colors.secondary.color())
                                
                                Text(viewModel.profile.userAddress.number)
                                    .font(GilroyFonts.font(style: .regular, size: 16))
                                    .foregroundColor(Colors.secondary.color())
                            }
                            
                            HStack{
                                Text(viewModel.profile.userAddress.zipCode)
                                    .font(GilroyFonts.font(style: .regular, size: 16))
                                    .foregroundColor(Colors.secondary.color())
                                Text(viewModel.profile.userAddress.city)
                                    .font(GilroyFonts.font(style: .regular, size: 16))
                                    .foregroundColor(Colors.secondary.color())
                            }
                            
                            Text(viewModel.profile.userAddress.country ?? "")
                                .font(GilroyFonts.font(style: .regular, size: 16))
                                .foregroundColor(Colors.black.color())
                            
                        }.padding()
                        
                        HStack{
                            Text("Payment Method")
                                .foregroundColor(Colors.black.color())
                                .bold()
                        }.padding(.leading , 20)
                            .padding(.top ,20)
                        Divider()
                        
                        VStack{
                            if viewModel.profile.paymentMethode.creditCard.creditCartIssClicked{
                                
                                HStack{
                                    Text("Credit/Debit Card").font(GilroyFonts.font(style: .bold, size: 14))
                                    
                                    Spacer()
                                    Image("card_logo 1")
                                        .resizable()
                                        .frame(width: 200, height: 40)
                                }
                                
                                
                                HStack{
                                    Text("Cart Number : ").font(GilroyFonts.font(style: .regular, size: 14))
                                    Spacer()
                                    Text(viewModel.profile.paymentMethode.creditCard.creaditNumber).font(GilroyFonts.font(style: .regular, size: 14))
                                }.padding(.top, 10)
                                
                            }
                            if viewModel.profile.paymentMethode.payPal.payPalisClicked{
                                
                                HStack{
                                    Text("PayPal").font(GilroyFonts.font(style: .bold, size: 14))
                                    Spacer()
                                    Image("paypal_logo")
                                        .resizable()
                                        .frame(width: 70, height: 60)
                                }
                                HStack{
                                    Text("Email Address : ").font(GilroyFonts.font(style: .regular, size: 14))
                                    Spacer()
                                    Text(viewModel.profile.paymentMethode.payPal.email).font(GilroyFonts.font(style: .regular, size: 14))
                                }.padding(.top, 10)
                            }
                            if viewModel.profile.paymentMethode.sepa.sepaClicked{
                                HStack{
                                    Text("Sepa").font(GilroyFonts.font(style: .bold, size: 14))
                                    Spacer()
                                    Image("sepa_logo")
                                        .resizable()
                                        .frame(width: 70 , height: 60)
                                }
                                HStack{
                                    Text("IBAN : ").font(GilroyFonts.font(style: .regular, size: 14))
                                    Spacer()
                                    Text(viewModel.profile.paymentMethode.sepa.iban).font(GilroyFonts.font(style: .regular, size: 14)).padding(.top, 10)
                                }
                                
                            }
                        }.padding(.horizontal)
                            .padding(.vertical ,20)
                        Divider()
                        VStack(alignment : .leading){
                            
                            HStack{
                                Image( "wallet").resizable()
                                    .frame(width: 30 , height: 30)
                                Text("you are saved").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 14))
                                Spacer()
                                Text(viewModel.calculateSavedMonay).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 14))
                                    .padding(.trailing ,20)
                            }.padding(.top,10)
                            Text("compared to UPV").font(GilroyFonts.font(style: .regular, size: 14))
                                .foregroundColor(Colors.secondary.color()).padding(.vertical,10)
                            
                        }.padding(.leading)
                        Divider()
                        
                        VStack(alignment : .leading){
                            HStack{
                                Text("Subtotal").font(GilroyFonts.font(style: .bold, size: 14))
                                    .foregroundColor(Colors.secondary.color())
                                Spacer()
                                
                                Text(viewModel.subPrice).font(GilroyFonts.font(style: .bold, size: 14))
                                    .foregroundColor(Colors.secondary.color())
                                    .padding(.trailing ,20)
                            }.padding(.top, 10)
                            HStack{
                                Text("packaging and processing").font(GilroyFonts.font(style: .bold, size: 14))
                                    .foregroundColor(Colors.secondary.color())
                                Spacer()
                                
                                Text("5.99 €").font(GilroyFonts.font(style: .bold, size: 14))
                                    .foregroundColor(Colors.secondary.color())
                                    .padding(.trailing ,20)
                            }.padding(.top, 20)
                            
                            HStack{
                                Text("Total Price")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 14))
                                    .foregroundColor(Colors.primary.color())
                                Spacer()
                                
                                Text(viewModel.totalPrice).padding(.trailing, 20)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.system(size: 14))
                                    .foregroundColor(Colors.primary.color())
                            }.padding(.top, 20)
                            
                            
                        }.padding(.leading)
                        
                        
                        
                        CustomButton(text: "Pay", textColor: Colors.white.color(), backgroundColor: Colors.primary.color(), action: {
                            isLoading = true
                            Task{
                             try await  viewModel.deleteAllProductsForCurrentUser()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    isLoading = false
                                    showConfirmation = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    navigateToHome = true
                      
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                 isNavigating = true 
                             }
                        })
                        .padding()
                        .padding(.top, 50)
                    }.navigationTitle("CheckOut")
                        .padding(.vertical, 50)
                    
                }
                
                if isLoading {
                    LoadingView()
                        .transition(.opacity)
                        .zIndex(1)
                }
                
                if showConfirmation {
                    ConfirmationView()
                        .transition(.opacity)
                        .zIndex(2)
                }
                
                NavigationLink(destination: Navigatoreator_Screen().navigationBarBackButtonHidden(true), isActive: $navigateToHome) {
                    EmptyView()
                }
          
                
            }
        }
    }
}

#Preview {
    CheckOut_Screen()
        .environmentObject(Cart_ViewModel())
}

