//
//  FavoriteCart_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 11.09.24.
//


import SwiftUI


struct FavoriteCart_Screen: View {
    var product: Product
    @EnvironmentObject private var viewModel  :  Favorite_ViewModel
    @EnvironmentObject private var cartViewModel  :  Cart_ViewModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                HStack{
                    HStack {
                        AsyncImage(url: product.artworkUrl) { image in
                            image
                                .resizable()
                                .frame(width: 120, height: 180)
                                .cornerRadius(10)
                        } placeholder: {
                            LoadingView()
                                .frame(width: 120, height: 180)
                                .cornerRadius(10)
                        }
                    }
                    .frame(width: 120, height: 180)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Colors.secondary.color().opacity(0.3), lineWidth: 1))
                    
                    HStack{
                        VStack(alignment:.leading){
                            
                            Text(product.title)
                                .font(GilroyFonts.font(style: .thin, size: 16))
                                .foregroundColor(Colors.black.color())
                                .padding(.bottom, 2)
                            
                            Text(product.description)
                                .font(GilroyFonts.font(style: .light, size: 12))
                                .foregroundColor(Colors.secondary.color())
                                .lineLimit(3)
                                .padding(.bottom, 6)
                            
                            HStack{
                                
                                ProductRatingView(rating: product.rating , fontStlyeRating: GilroyFonts.font(style: .thin, size: 10) , fontStlyeCount: GilroyFonts.font(style: .light, size: 10))
                                
                            }
                        }
                    }
                }
                
                HStack{
                    
                    Image(systemName: "box.truck")
                    Text("Lieferbar - \("in 2- 3 work days")")
                        .font(GilroyFonts.font(style: .semiBold, size: 12))
                    
                        .padding(.bottom, 4)
                }.padding(.top ,5 )
                HStack{
                    Text("Seller:")
                        .font(.subheadline)
                        .foregroundColor(Colors.secondary.color())
                        .padding(.bottom, 8)
                        .padding(.top, 8)
                    Text( "\("U-Store")")
                        .font(GilroyFonts.font(style: .bold, size: 14))
                        .foregroundColor(Colors.primary.color())
                        .padding(.bottom, 8)
                        .padding(.top, 8)
                }
                VStack(alignment:.trailing) {
                    
                    HStack{
                        Text("20%")
                            .foregroundColor(Colors.white.color())
                            .padding(3)
                        
                    }.background(Colors.error.color().opacity(0.9))
                        .cornerRadius(8)
                    
                    Text(product.originalPrice)
                        .font(GilroyFonts.font(style: .semiBold, size: 14))
                        .strikethrough()
                        .foregroundColor(Colors.secondary.color())
                    
                    Text(product.discountedPrice)
                        .bold()
                        .foregroundColor(Colors.error.color())
                    
                    HStack{
                        
                        CustomButton(text: "Delete", textColor: Colors.white.color(), backgroundColor: Colors.secondary.color().opacity(0.3), action: {
                            Task{
                                try await viewModel.deleteFavoriteByProductId(productId:product.id)
                            }
                            LoggerManager.logInfo("test delete favorite buton ")
                            
                        } ,image:Image(systemName: "trash")).frame(width: 150 )
                        
                        Spacer()
                        
                        CustomButton(text: "Add to cart", textColor: Colors.white.color(), backgroundColor: Colors.primary.color(), action: {
                            Task{
                                try await viewModel.deleteFavoriteByProductId(productId: product.id)
                                try await cartViewModel.addToCart(productId:product.id)
                               
                            }
                        } ,image:Image(systemName: "cart"))
                        
                    }
                }
                
            }.padding()
                .background(Colors.secondary.color().opacity(0.08))
            
            
        }
    }
}
#Preview {
    FavoriteCart_Screen(product: .sample)
        .environmentObject(Favorite_ViewModel())
        .environmentObject(Cart_ViewModel())
}

