//
//  DeliveryAddress_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//

import SwiftUI
import SwiftUI

struct DeliveryAddress_Screen: View {
    @EnvironmentObject var viewModel : Account_ViewModel
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Street and Number")
                            .font(.headline)
                            .padding(.vertical, 10)) {
                    HStack {
                        Image(systemName: "house.fill")
                            .foregroundColor(Colors.secondary.color().opacity(0.3))
                        TextField("Street", text: Binding(
                            get: { viewModel.profile.userAddress.street },
                            set: { viewModel.profile.userAddress.street = $0 }
                        ))
                        .disabled(!isEditing)
                    }

                    HStack {
                        Image(systemName: "numbersign")
                            .padding(.leading, 7)
                            .foregroundColor(Colors.secondary.color().opacity(0.3))
                        TextField("Nr.", text: Binding(
                            get: { viewModel.profile.userAddress.number },
                            set: { viewModel.profile.userAddress.number = $0 }
                        ))
                        .disabled(!isEditing)
                    }
                }

                Section(header: Text("Area")
                            .font(.headline)
                            .padding(.vertical, 10)) {
                    HStack {
                        Image(systemName: "building.2.fill")
                            .foregroundColor(Colors.secondary.color().opacity(0.3))
                        TextField("City", text: Binding(
                            get: { viewModel.profile.userAddress.city },
                            set: { viewModel.profile.userAddress.city = $0 }
                        ))
                        .disabled(!isEditing)
                    }

                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(Colors.secondary.color().opacity(0.3))
                        TextField("State", text: Binding(
                            get: { viewModel.profile.userAddress.state ?? "" },
                            set: { viewModel.profile.userAddress.state = $0 }
                        ))
                        .disabled(!isEditing)
                    }

                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Colors.secondary.color().opacity(0.3))
                        TextField("Zip Code", text: Binding(
                            get: { viewModel.profile.userAddress.zipCode},
                            set: { viewModel.profile.userAddress.zipCode = $0 }
                        ))
                        .keyboardType(.numberPad)
                        .disabled(!isEditing)
                    }
                }

                Section(header: Text("Country")
                            .font(.headline)
                            .padding(.vertical, 10)) {
                    HStack {
                        Image(systemName: "globe.americas.fill")
                            .foregroundColor(Colors.secondary.color().opacity(0.3))
                        TextField("Country", text: Binding(
                            get: { viewModel.profile.userAddress.country ?? "" },
                            set: { viewModel.profile.userAddress.country = $0 }
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

// Preview for SwiftUI
#Preview {
    DeliveryAddress_Screen()
        .environmentObject(Account_ViewModel())
      
}
