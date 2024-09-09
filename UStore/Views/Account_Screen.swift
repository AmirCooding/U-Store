//
//  Account_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//


import SwiftUI

struct Account_Screen: View {
    @StateObject private var viewModel = Account_ViewModel()
    var body: some View {
        NavigationStack {
          
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


#Preview {
    Account_Screen()
}
