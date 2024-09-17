//
//  SignIn_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct SignIn_Screen: View {
    @StateObject private var viewModel = UStore_UserAuth_ViewModel()
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(alignment: .leading) {
                    
                    HStack(){
                        Spacer()
                        Image("logo_image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 60)
                        Spacer()
                    }.padding(.top, 30)
                    
                    Text("Sign In")
                        .font(GilroyFonts.font(style: .semiBold, size: 26))
                        .foregroundColor(Colors.black.color())
                        .padding(.bottom, 5)
                        .padding(.top, 20)
                    // MARK: - change it
                    CustomTextField(text: $viewModel.authForm.email, placeholder: "Enter your Email", title: "Email", iconName: nil, showIcon: false)
                    
                    CustomTextField(text: $viewModel.authForm.password, placeholder: "Enter your Password", title: "Password", isSecure: true)
                    
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: ForgetPassword_Screen(),
                            label: {
                                Text("Forget Password?").font(GilroyFonts.font(style: .semiBold, size: 14)).foregroundColor(.blue)
                                
                            }
                        )
                    }
                    .padding(.top, 10)
                    
                    CustomButton(
                        text: "Sign In",
                        textColor: .white,
                        backgroundColor: !viewModel.authForm.email.isEmpty &&  !viewModel.authForm.password.isEmpty ? Colors.primary.color() : Colors.primary.color().opacity(0.6),
                        action: {
                            Task{
                                try await   viewModel.handelSignIn()
                                
                            }
                        }
                    )
                    .disabled(viewModel.authForm.email.isEmpty && viewModel.authForm.password.isEmpty)
                    .padding(.top, 20)
                    .navigationDestination(isPresented: $viewModel.authForm.navigateToView) {
                        Navigatoreator_Screen()
                            .navigationBarBackButtonHidden(true)
                    }
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Don't have an Account?")
                            .font(GilroyFonts.font(style: .semiBold, size: 14))
                            .foregroundColor(Colors.secondary.color())
                        
                        NavigationLink(destination: SignUp_Screen()) {
                            Text("Sign Up")
                                .font(GilroyFonts.font(style: .semiBold, size: 14))
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    Divider().padding(.top, 20)
                    
                    CustomButton(
                        text: "Continue With Google",
                        textColor: .white,
                        backgroundColor: Colors.google.color(),
                        action: {
                            Task{
                                try await   viewModel.handleLoginWithGoogle()
                                
                            }
                            
                        },
                        image: Image("logo-google")
                    ).padding(.top, 20)
                        .navigationDestination(isPresented: $viewModel.authForm.navigateToView) {
                            Navigatoreator_Screen()
                                .navigationBarBackButtonHidden(true)
                        }
                    
                    CustomButton(
                        text: "Continue With Facebook",
                        textColor: .white,
                        backgroundColor: Colors.faceBook.color(),
                        action: {
                            // MARK : call handel Login with Facebook
                            Task{
                                try await viewModel.handleLoginWithGoogle()
                            }
                        },
                        image: Image("facebook_image")
                    )
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .alert(isPresented: $viewModel.authForm.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.authForm.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            
            if viewModel.authForm.isLoading {
                LoadingView()
            }
        }
    }
}

#Preview {
    SignIn_Screen()
}
