//
//  About_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//


import SwiftUI

struct About_Screen: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack{
                Spacer()
                Image("Logo-image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                Spacer()
                
            }
            // App Name and Version
            Text("App Name")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Version 1.0.0")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Description
            Text("This app is designed to help users manage their tasks efficiently with an intuitive interface and powerful features.")
                .font(.body)
                .padding(.vertical, 10)

            // Developer Information
            VStack(alignment: .leading, spacing: 5) {
                Text("Developed by:")
                    .font(.headline)
                
                Text("Uniqe-Store")
                    .font(.body)
                    .foregroundColor(.blue)
                
                Text("Contact: support@uniqestore.com")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding(.top, 20)

            Spacer()

            // Footer with Links
            HStack {
                Spacer()
                CustomButton(text: "Visit our Website", textColor: Colors.white.color(), backgroundColor: Colors.primary.color(), action: {}).frame(width: 200)
                Spacer()
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 30)
        .navigationTitle("About")
    }
}

#Preview {
    About_Screen()
}
