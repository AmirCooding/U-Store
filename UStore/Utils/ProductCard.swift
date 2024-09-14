//
//  ProductCard.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation


import SwiftUI

struct ProductCard: View {
    @StateObject private var viewModel  = ProductCard_ViewModle()
    var product: Product

    var body: some View {
        NavigationLink(destination: ProductDetails_Screen(product: product)) {
            VStack {
                VStack(spacing: 10) {
                    AsyncImage(url: product.artworkUrl) { image in
                        image
                            .resizable()
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        LoadingView()
                            .frame(width: 150, height: 150)
                    }
                    
                    HStack {
                        Text(product.title)
                            .font(GilroyFonts.font(style: .bold, size: 18))
                            .foregroundColor(Colors.black.color())
                            .lineLimit(1)
                        
                        Spacer()
                        Button(action: {
                            Task {
                                if viewModel.isLiked{
                                    try await viewModel.delteFavoriteByProductId(productid: product.id)
                                } else {
                                    try await viewModel.addToFavorite(productId: product.id)
                                }
                            }
                        }) {
                            Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.isLiked ? Colors.error.color() : Colors.secondary.color())
                                .font(.system(size: 20))
                        }
                        .padding(.trailing, 10)

                    }
                    .padding(.top, 5)
                    
                    Text(product.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .font(GilroyFonts.font(style: .medium, size: 14))
                        .lineLimit(1)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.originalPrice)
                                .font(GilroyFonts.font(style: .semiBold, size: 14))
                                .strikethrough()
                                .foregroundColor(Colors.secondary.color())
                            
                            Text(product.discountedPrice)
                                .font(GilroyFonts.font(style: .bold, size: 18))
                                .foregroundColor(.green)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Add to cart action
                        }) {
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(Colors.primary.color())
                                .font(.system(size: 40))
                        }
                    }
                }
                .padding(5)
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            .frame(width: 150)
        }
        .padding()
    }
 
}

#Preview {
    NavigationStack {
        ProductCard(product: .sample)
    }
}
