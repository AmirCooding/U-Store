//
//  SignUp_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//


import SwiftUI
import PhotosUI

struct SignUp_Screen: View {
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var showImagePicker: Bool = false
    @StateObject private var viewModel = UStore_UserAuth_ViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    
                    HStack {
                        Spacer()
                        Image("logo_image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 60)
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    HStack{
                    
                        VStack{
                            
                            Text("Create an Account")
                                .font(GilroyFonts.font(style: .semiBold, size: 26))
                                .foregroundColor(Colors.black.color())
                                .padding(.top, 20)
                            
                            
                            Text("Enter your details to sign up")
                                .foregroundColor(Colors.secondary.color())
                        }.padding(.trailing, 30)
                        
                        VStack {
                            PhotosPicker(selection: $selectedImage, matching: .images, photoLibrary: .shared()) {

                                       if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
                                           Image(uiImage: uiImage)
                                               .resizable()
                                               .scaledToFill()
                                               .clipShape(Circle()) // Circle shape
                                               .frame(width: 100, height: 100)
                                               .overlay(Circle()
                                                   .stroke(Color.secondary.opacity(0.7), lineWidth: 2))
                                               .shadow(radius: 5)
                                       } else {
                                           // Placeholder when no image is selected
                                           Text("Add photo")
                                               .frame(width: 100, height: 100)
                                               .clipShape(Circle())
                                               .foregroundColor(Color.secondary.opacity(0.5))
                                               .overlay(Circle()
                                                   .stroke(Color.secondary.opacity(0.7), lineWidth: 2))
                                               .shadow(radius: 5)
                                       }
                                   }
                                   .padding(.top, 20)
                                   .onChange(of: selectedImage) { newItem in
                                       guard let newItem = newItem else { return }
                                       
                                       // Retrieve the selected image
                                       newItem.loadTransferable(type: Data.self) { result in
                                           switch result {
                                           case .success(let data):
                                               viewModel.imageData = data // Update image data in ViewModel
                                           case .failure(let error):
                                               print("Failed to load image: \(error)")
                                           }
                                       }
                                   }
                               }
                        
                        /*
                        PhotosPicker(selection: $selectedImage, matching: .images,photoLibrary: .shared()){
                                Text("Add photo")
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .foregroundColor(Colors.secondary.color().opacity(0.2))
                                .overlay(Circle()
                                    .stroke(Colors.secondary.color().opacity(0.7), lineWidth: 2))
                                  
                                .shadow(radius: 5)
                        }.padding(.top , 20)
            */
                    }

                    // Full Name TextField
                    CustomTextField(text: $viewModel.profile.fullName, placeholder: "Enter your Full Name", title: "Full Name", iconAfter: "person" , showIcon: true )
                    
                    // Email TextField
                    CustomTextField(text: $viewModel.email, placeholder: "Enter your Email", title: "Email" , iconAfter: "envelope" , isSecure: false)
                    
                    // Tele TextField
                    CustomTextField(text: $viewModel.profile.tel, placeholder: "Enter your Phone Nummber", title: "Phone" , iconAfter: "phone" , isSecure: false)
                    
                    // Password TextField
                    CustomTextField(text: $viewModel.authForm.password, placeholder: "Enter your Password", title: "Password",iconBefor: "eye.slash.fill" , iconAfter: "eye" , isSecure: true)
                    
                    // Confirm Password TextField
                    CustomTextField(text: $viewModel.authForm.confirmPassword, placeholder: "Confirm your Password", title: "Confirm Password",iconBefor: "eye.slash.fill" , iconAfter: "eye", isSecure: true)
                    
                    
                    Checkbox(isChecked: $viewModel.authForm.isTermsAccepted).padding(.top, 30)
                    
                    
                    
                    CustomButton(
                        text: "Sign Up",
                        textColor: .white,
                        backgroundColor: viewModel.authForm.isTermsAccepted ? Colors.primary.color() : Colors.primary.color().opacity(0.6),
                        action: {
                            Task {
                                try await viewModel.handleSignUp()
                            }
                        }
                    )     .disabled(!viewModel.authForm.isTermsAccepted)
                        .padding(.top, 20)
                        .navigationDestination(isPresented: $viewModel.authForm.navigateToView) {
                            SignIn_Screen()
                                .navigationBarBackButtonHidden(true)
                        }
                    
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            } // End of ScrollView
            .alert(isPresented: $viewModel.authForm.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.authForm.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
}
#Preview {
    SignUp_Screen()
}


struct Checkbox: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(isChecked ? .green : Colors.primary.color())
                    .padding(.bottom, 12)
                Text("By checking this box, you are agreeing to our terms of service.")
                    .foregroundColor(Colors.primary.color())
                    .font(GilroyFonts.font(style: .thin, size: 16))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}




