//
//  LoadingView.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//

import Foundation

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Colors.secondary.color().opacity(0.3)
                .ignoresSafeArea() // Ensure it covers the entire screen
            
            VStack {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(Colors.primary.color())
                    .foregroundColor(Colors.primary.color())
                  
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    LoadingView()
}
