//
//  ProductDetails_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import SwiftUI

struct ProductDetails_Screen: View {
    @StateObject private var viewModel  = DetailsScreen_ViewModel()
    let product: Product
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isFavorite: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading) {
                    AsyncImage(url: product.artworkUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } placeholder: {
                        LoadingView()
                            .frame(height: 300)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                }
                .padding(.vertical)
                HStack {
                    Text(product.title)
                        .font(GilroyFonts.font(style: .bold, size: 22))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
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
                .padding(.horizontal)
                HStack{
                    
                    VStack(alignment: .leading , spacing: 15) {
                        Text("Category: \(product.category.rawValue.capitalized)")
                            .font(GilroyFonts.font(style: .thin, size: 16))
                            .foregroundColor(Colors.primary.color().opacity(0.5))
                            .padding(.bottom)
                        
                        VStack(alignment: .leading){
                            Text(product.discountedPrice)
                                .font(GilroyFonts.font(style: .semiBold, size: 22))
                                .foregroundColor(Colors.black.color())
                            
                            Text("\(product.originalPrice)")
                                .font(GilroyFonts.font(style: .thin, size: 18))
                                .strikethrough()
                                .foregroundColor(Colors.secondary.color().opacity(0.5))
                        }
                        
                        VStack(alignment: .leading){
                            Text("Description")
                                .font(.headline)
                            
                            Text(product.description)
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        
                        ProductRatingView(rating: product.rating ,
                                          fontStlyeRating: GilroyFonts.font(style: .semiBold, size: 16) , fontStlyeCount: GilroyFonts.font(style: .regular, size: 12)
                        )
                        
                        CustomButton(
                            text: "Add to Cart",
                            textColor: Colors.white.color(),
                            backgroundColor: Colors.primary.color(),
                            action: {
                                Task {
                                    do {
                                        try await viewModel.addToCart(productId: product.id)
                                        alertMessage = "Added Product in Cart"
                                        showAlert = true
                                    } catch {
                                        alertMessage = "Failed to add Product to Cart"
                                        showAlert = true
                                    }
                                }
                            }
                        )
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Success"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    
                }
                .padding(.horizontal)
                Spacer()
            }.padding(.top,15)
        }.onAppear{
            Task{
                try await viewModel.toggleColorFavoriteIcon(productId: product.id)
            }
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
}






// Preview

#Preview {
    ProductDetails_Screen(product: .sample)
}
