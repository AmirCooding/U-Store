//
//  CustomButton.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//


import SwiftUI
struct CustomButton: View {
    var text: String
    var textColor: Color
    var iconColor : Color? = Colors.white.color()
    var backgroundColor: Color
    var action: () -> Void
    var image: Image? // Optional image

  
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 20)
                        .foregroundColor(iconColor)
                }
                
                Text(text)
                    .foregroundColor(textColor)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .background(backgroundColor)
            .cornerRadius(8)
         
        }
    
    }
}

#Preview {
    CustomButton(
        text: " Google",
        textColor: .white,
        backgroundColor:.gray,
        action: {
            print("Test Butten")
        },
        image: Image(systemName: "star.fill")
    )
    .padding()
}

