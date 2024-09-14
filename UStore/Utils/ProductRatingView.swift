//
//  ProductRatingView.swift
//  UStore
//
//  Created by Amir Lotfi on 11.09.24.
//

import SwiftUI


struct ProductRatingView: View {
    let rating: Rating
    let fontStlyeRating : Font
    let fontStlyeCount : Font
   

    var body: some View {
        VStack(alignment:.leading) {
            HStack{
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(rating.rate!.rounded()) ? "star.fill" : "star")
                            .foregroundColor(index < Int(rating.rate!.rounded()) ? .yellow : .gray)
                    }
                }
                Text("(\(String(format: "%.1f", rating.rate!)))")
                    .foregroundColor(Colors.secondary.color())
                    .font(fontStlyeRating)
            }.padding(.bottom,3)
            
      
                if let count = rating.count {
                    
                    Text("(\(count) reviews)")
                        .font(fontStlyeCount)
                        .foregroundColor(.gray)
                    
                } else {
                    Text("(No reviews)")
                        .font(fontStlyeCount)
                        .foregroundColor(Colors.secondary.color())
                }
            
        }.padding(.top, 20)
            .padding(.bottom ,30)
       
    }
}


