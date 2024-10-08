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
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
                    .padding(.bottom)
                Divider()
                
                Text("Payment Confirmed!")
                    .font(GilroyFonts.font(style: .semiBold, size: 20))
                    .foregroundColor(Colors.secondary.color())
                    .padding(.top, 10)
            }
            .frame(maxWidth: 300, maxHeight: 200)
            .background(Colors.white.color())
                .cornerRadius(25)
        }
    }
}

#Preview {
    ConfirmationView()
}
