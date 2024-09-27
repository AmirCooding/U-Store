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
                HStack(alignment:.center) {
                    if let imageData = viewModel.imageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                           
                    } else {
                        ZStack {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 80, height: 80)
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.profile.fullName.isEmpty ? "NO Name for user" : viewModel.profile.fullName)
                            .font(GilroyFonts.font(style: .bold, size: 24))
                            .foregroundColor(.primary)
                        
                        Text(viewModel.profile.email.isEmpty ? "NO email for user" : viewModel.profile.email)
                            .font(GilroyFonts.font(style: .bold, size: 14))
                            .foregroundColor(viewModel.profile.email.isEmpty ? Colors.faceBook.color() : .blue)
                    }
                    .padding(.leading, 10)
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
                        NavigationLink(destination: MyDetails_Screen().environmentObject(viewModel)) {
                            HStack {
                                Image(systemName: "person.crop.rectangle")
                                    .foregroundColor(.primary)
                                Text("My Details")
                            }
                        }
                        NavigationLink(destination: DeliveryAddress_Screen().environmentObject(viewModel)) {
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
                        Task {
                            try viewModel.handelSignOut()
                        }
                    },
                    image: Image(systemName: "rectangle.portrait.and.arrow.right")
                )
                .padding()
                .navigationDestination(isPresented: $viewModel.authForm.navigateToView) {
                    SignIn_Screen()
                        .navigationBarBackButtonHidden(true)
                }
                
            }
            .onAppear {
                Task {
                    try await viewModel.fetchUserProfile()
                }
            }
            .navigationTitle("Account")
        }
    }
}

#Preview {
    Account_Screen()
}
