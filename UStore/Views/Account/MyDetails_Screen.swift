//
//  MyDetails_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//


import SwiftUI
import PhotosUI

struct MyDetails_Screen: View {
    @EnvironmentObject var viewModel : Account_ViewModel
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var isEditing: Bool = false
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image")
                            .font(.headline)) {
                    HStack {
                        VStack {
                            PhotosPicker(selection: $selectedImage, matching: .images, photoLibrary: .shared()) {
                                HStack {
                                    if let imageData = viewModel.imageData,
                                       let uiImage = UIImage(data: imageData) {
                                        Spacer()
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 180, height: 130)
                                            .background(Color.gray)
                                            .cornerRadius(8)
                                           
                                        Spacer()
                                         
                                    } else {
                                        Spacer()
                                        ZStack {
                                            Image("")
                                                .resizable()
                                                .frame(width: 180, height: 130)
                                                .background(Color.gray)
                                                .cornerRadius(8)
                                             
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                    }
                                }.onAppear {
                                    Task{
                                        try await  viewModel.fetchImageProfile()
                                    }
                                }
                            }
                            .onChange(of: selectedImage) { oldItem ,newItem in
                                guard let newItem = newItem else { return }
                                
                                // Retrieve the selected image data
                                newItem.loadTransferable(type: Data.self) { result in
                                    switch result {
                                    case .success(let data):
                                        if let data = data {
                                            // Update image data in ViewModel
                                            viewModel.imageData = data
                                        } else {
                                            print("No image data available.")
                                        }
                                    case .failure(let error):
                                        print("Failed to load image: \(error)")
                                    }
                                }
                            }
                        }

                    }

                                
                }
                
                Section(header: Text("FULL NAME")
                            .font(.headline)
                            .padding(.vertical, 10)) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(Colors.secondary.color().opacity(0.3))
                        TextField("Full Name", text: Binding(
                            get: { viewModel.profile.fullName },
                            set: { viewModel.profile.fullName = $0 }
                        ))
                        .disabled(!isEditing)
                    }

                    HStack {
                        Image(systemName: "phone.fill")
                            .padding(.leading, 7)
                            .foregroundColor(Colors.secondary.color().opacity(0.3))
                        TextField("TEL", text: Binding(
                            get: { viewModel.profile.tel },
                            set: { viewModel.profile.tel = $0 }
                        ))
                        .disabled(!isEditing)
                    }
                }

                if isEditing {
                    Button(action: {
                        isEditing = false
                        Task {
                            do {
                                try await viewModel.updateUserProfile(profile: viewModel.profile)
                                try await viewModel.updateProfileAndFetchData()
                            } catch {
                                print("Error updating profile: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Text("Save Address")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                }
            }
            .navigationTitle("Delivery Address")
            .navigationBarItems(trailing: Button(action: {
                isEditing.toggle()
            }) {
                Text(isEditing ? "Done" : "Edit")
                    .foregroundColor(.blue)
            })
        }
    }
}

#Preview {
    MyDetails_Screen()
        .environmentObject(Account_ViewModel())
}
