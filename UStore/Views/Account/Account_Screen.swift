//
//  Account_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//


import SwiftUI
import FirebaseAuth
struct Account_Screen: View {
    @StateObject private var viewModel = Account_ViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                HStack {
                    ZStack{
                        Image("")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .background(.gray)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Colors.white.color())
                        
                        
                    }
                   
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(Auth.auth().currentUser?.uid ?? "No Current user")
                                .font(GilroyFonts.font(style: .bold, size: 24))
                           
                        }
                        Text(Auth.auth().currentUser?.email ?? "No Current user")
                            .font(GilroyFonts.font(style: .regular, size: 18))
                            .foregroundColor(Colors.faceBook.color())
                        
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding()
                
                // List Section
                List {
                    Section {
                        NavigationLink(destination: Orders_Screen()) {
                            HStack {
                                Image(systemName: "bag")
                                    .foregroundColor(.primary)
                                Text("Orders")
                            }
                        }
                        NavigationLink(destination: MyDetails_Screen()) {
                            HStack {
                                Image(systemName: "person.crop.rectangle")
                                    .foregroundColor(.primary)
                                Text("My Details")
                            }
                        }
                        NavigationLink(destination: DeliveryAddress_Screen()) {
                            HStack {
                                Image(systemName: "location")
                                    .foregroundColor(.primary)
                                Text("Delivery Address")
                            }
                        }
                        NavigationLink(destination: PaymentMethods_Screen()) {
                            HStack {
                                Image(systemName: "creditcard")
                                    .foregroundColor(.primary)
                                Text("Payment Methods")
                            }
                        }
                        NavigationLink(destination: PromoCard_Screen()) {
                            HStack {
                                Image(systemName: "ticket")
                                    .foregroundColor(.primary)
                                Text("Promo Card")
                            }
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: Notifications_Screen()) {
                            HStack {
                                Image(systemName: "bell")
                                    .foregroundColor(.primary)
                                Text("Notifications")
                            }
                        }
                        NavigationLink(destination: Help_Screen()) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.primary)
                                Text("Help")
                            }
                        }
                        NavigationLink(destination: About_Screen()) {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.primary)
                                Text("About")
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                Spacer()
                CustomButton(
                    text: "Logout",
                    textColor: Colors.white.color(),
                    iconColor: Colors.white.color(),
                    backgroundColor: Colors.error.color(),
                    action: {
                        Task{
                             try viewModel.handelSignOut()
                        }
                    } ,
                    image: Image(systemName: "rectangle.portrait.and.arrow.right")
                ).padding()
                .navigationDestination(isPresented: $viewModel.authForm.navigateToView) {
                    SignIn_Screen()
                        .navigationBarBackButtonHidden(true)
                }
        
                    }
                    .navigationTitle("Account")
            }
        }
    }


#Preview {
    Account_Screen()
}

/*

 */
