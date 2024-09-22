//
//  ResetPassword.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct ForgetPassword_Screen: View {
    
    @StateObject private var viewModel = UStore_UserAuth_ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text("Forgot Password")
                    .font(GilroyFonts.font(style: .semiBold, size: 26))
                    .foregroundColor(Colors.black.color())
                    .padding(.top, 50)
                
                Text("Enter your email to reset your password.")
                    .foregroundColor(Colors.secondary.color())
                
                // Email TextField
                CustomTextField(
                    text: $viewModel.authForm.email,
                    placeholder: "Enter your Email",
                    title: "Email",
                    iconBefor:  "envelope",
                    showIcon: false
                )
                .padding(.top, 20)
                
                CustomButton(
                    text: "Send Reset Email",
                    textColor: .white,
                    backgroundColor: !viewModel.authForm.email.isEmpty ? Colors.primary.color() : Colors.primary.color().opacity(0.6),
                    action: {
                        Task{
                            try await viewModel.handleResetPassword(email: viewModel.authForm.email )
                        }
                    }
                )
                .padding(.top, 30)
                .disabled(viewModel.authForm.email.isEmpty)
                .padding(.top, 20)
                .navigationDestination(isPresented: $viewModel.authForm.navigateToView) {
                    SignIn_Screen()
                        .navigationBarBackButtonHidden(true)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .alert(isPresented: $viewModel.authForm.showAlert) {
                Alert(
                    title: Text("Message"),
                    message: Text(viewModel.authForm.alertMessage),
                    dismissButton: .default(Text("OK"), action: {
                        viewModel.authForm.navigateToView = true
                    }))
            }
            
        }
    }
}

#Preview {
    ForgetPassword_Screen()
}
