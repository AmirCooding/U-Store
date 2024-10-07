//
//  ConfirmationView.swift
//  UStore
//
//  Created by Amir Lotfi on 07.10.24.
//

import SwiftUI



struct ConfirmationView: View {
    var body: some View {
        ZStack {
            Colors.secondary.color().opacity(0.3)
                .ignoresSafeArea()

            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Colors.primary.color())
                
                Text("Payment Confirmed!")
                    .font(.title)
                    .foregroundColor(Colors.primary.color())
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ConfirmationView()
}
