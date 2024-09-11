//
//  NoContentOverlay.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import SwiftUI


struct NoContentOverlay: View {
    let imageURL: URL
    let overlayText: String

    var body: some View {
        ZStack {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(10)
                    .clipped()
            } placeholder: {
                Color.gray.opacity(0.3) 
            }
            
            Text(overlayText)
                .font(.largeTitle)
                .foregroundStyle(.white)
                .shadow(radius: 5)
        }
        .frame(height: 200)
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

