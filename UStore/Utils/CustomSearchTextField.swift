//
//  CustomSearchTextField.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import SwiftUI


struct CustomSearchTextField: View {
    @Binding var text: String

    var body: some View {
        HStack {
            // Search icon inside the TextField
            Image(systemName: "magnifyingglass")
                .foregroundColor(Colors.secondary.color().opacity(0.4))
            
            // The actual TextField
            TextField("", text: $text)
                .foregroundColor(Colors.black.color()) // Set text color to make sure it's visible
                .padding(.leading, 5)
                .padding(.vertical, 7)
                .background(
                    Text(text.isEmpty ? "search..." : "")
                        .foregroundColor(Colors.secondary.color().opacity(0.3))
                        .padding(.leading, 5),
                    alignment: .leading
                )
        }
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Colors.secondary.color().opacity(0.2))  // Set background for the entire field
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Colors.secondary.color().opacity(0.3), lineWidth: 0.1)  // Border with stroke
        )
    }
}

#Preview {
    CustomSearchTextField(text: .constant(""))
}
