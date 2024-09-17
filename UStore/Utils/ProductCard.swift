//
//  ProductCard.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation


import SwiftUI

struct ProductCard: View {
    @StateObject private var viewModel  = ProductCard_ViewModel()
    @State private var toogleFavorite : Bool = false
    var product: Product
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: ProductDetails_Screen(product: product)) {
                    
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
                                  try await  viewModel.toggleFavorites(productId: product.id)
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
                                Task {
                                    try await viewModel.addToCart(productId:product.id)
                                }
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
            }.onAppear{
                Task{
                    try await viewModel.toggleColorFavoriteIcon(productId: product.id) 
                }
            }
            .padding()
        }
    }
}

#Preview {
        ProductCard(product: .sample)
        .environmentObject(Favorite_ViewModel())
        .environmentObject(Cart_ViewModel())
}
