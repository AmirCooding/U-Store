//
//  FilterSheet_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 14.09.24.
//

import SwiftUI
import SwiftUI

struct FilterSheet_Screen: View {
    private var viewModel  = Explore_ViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var min: String = ""
    @State var max: String = ""
    @State var selectedRating: Int = 3 
    
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
                
            }.padding(.top ,10)
             .padding(.bottom , 50)
            
            Divider()
            
            HStack {
                Text("Rate")
                    .font(GilroyFonts.font(style: .semiBold, size: 18))
                    .padding(.leading, 20)
                Spacer()
            }
                HStack{
                Text("From")
                    .font(GilroyFonts.font(style: .thin, size: 18))
                    .padding(.leading, 20)
                Spacer()
                
                Picker("Rating", selection: $selectedRating) {
                    ForEach(1..<6) { rating in
                        Text("\(rating) stars").tag(rating)
                    }
                }
                .pickerStyle(.automatic)
                .tint(Colors.primary.color())
                .padding(.horizontal, 20)
            }
            
            CustomButton(
            text: "Search",
            textColor: Colors.white.color(),
            backgroundColor: Colors.primary.color(),
            action: {
            viewModel.filterProductsByPrice(min: Double(min) ?? 0.00, max: Double(max) ?? 0.00)
                
            },
            image: nil
            ).padding(.horizontal , 20)
            Spacer()
        }.padding(.top, 20)
        
    }
    
}

#Preview {
    FilterSheet_Screen()
}
