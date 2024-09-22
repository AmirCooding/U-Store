//
//  FilterSheet_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 14.09.24.
//

import SwiftUI
struct FilterSheet_Screen: View {
    var viewModel: Home_ViewModel
    var category: String
    @Binding var filteredProducts: [Product]
    @Environment(\.presentationMode) var presentationMode
    @State var min: String = ""
    @State var max: String = ""
    @State var selectedRating: Int = 0
    
    var body: some View {
        VStack(spacing:20){
            HStack {
                Text("Filter")
                    .font(GilroyFonts.font(style: .semiBold, size: 22))
                    .padding(.leading, 20)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply.circle")
                        .foregroundColor(Colors.primary.color())
                        .font(GilroyFonts.font(style: .thin, size: 24))
                        .padding(.trailing, 20)
                }
            }
            Divider()
            HStack {
                Text("Price")
                    .font(GilroyFonts.font(style: .semiBold, size: 18))
                    .padding(.leading, 20)
                Spacer()
            }
            
            HStack {
                Spacer()
                CustomTextField(text: $min, placeholder: "0.00", title: "Min", showIcon: false)
                    .frame(width: 140, height: 20)
                Spacer()
                
                CustomTextField(text: $max, placeholder: "0.00", title: "Max", showIcon: false)
                    .frame(width: 140, height: 20)
                Spacer()
            }
            .padding(.top ,10)
            .padding(.bottom ,50)
            
            Divider()
            
            HStack {
                Text("Rate")
                    .font(GilroyFonts.font(style: .semiBold, size: 18))
                    .padding(.leading, 20)
                Spacer()
            }
            
            HStack {
                Text("Select Rating")
                    .font(.headline)
                Spacer()
                
                
                Picker("Rating", selection: $selectedRating) {
                    ForEach(0..<6) { rating in
                        if rating == 0 {
                            Text("Not selected").tag(0)
                        } else {
                            Text("\(rating) stars").tag(rating)
                        }
                    }
                }
                .pickerStyle(.automatic)
                .tint(Colors.primary.color())
                .padding(.horizontal, 20)
                .onChange(of: selectedRating) { oldValue, newValue in
                    print("Rating changed from: \(oldValue) to: \(newValue)")
                }
                
                
            }
            .padding()
            
            
            
            CustomButton(
                text: "Search",
                textColor: Colors.white.color(),
                backgroundColor: Colors.primary.color(),
                action: {
                    let minPrice = Double(min) ?? 0.00
                    let maxPrice = Double(max) ?? Double.greatestFiniteMagnitude
                    
                    Task {
                        do {
                            
                            if selectedRating == 0 {
                                filteredProducts = try await viewModel.filterProductsByPrice(min: minPrice, max: maxPrice, category: self.category)
                            } else {
                                filteredProducts = try await viewModel.filterProductsByRatingAndPrice(min: minPrice, max: maxPrice, selectedRating: selectedRating , category: self.category)
                            }
                            presentationMode.wrappedValue.dismiss()
                            
                        } catch {
                            LoggerManager.logInfo("Filtering error: \(error.localizedDescription)")
                        }
                    }
                },
                image: nil
            )
            .padding(.horizontal, 20)
            Spacer()
        }
        .padding(.top, 20)
    }
}


#Preview {
    // Mock viewModel for preview
    let mockViewModel = Home_ViewModel()
    @State var mockFilteredProducts: [Product] = [.sample]
    return FilterSheet_Screen(
        viewModel: mockViewModel,
        category: "Womans",
        filteredProducts: $mockFilteredProducts
    )
}
