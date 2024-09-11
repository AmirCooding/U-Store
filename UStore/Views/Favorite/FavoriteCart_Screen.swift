//
//  FaivoriteCart_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 11.09.24.
//

import SwiftUI


struct FavoriteCart_Screen: View {
    var product: Product

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack{
                    HStack {
                        AsyncImage(url: product.artworkUrl) { image in
                            image
                                .resizable()
                                .frame(width: 150, height: 220)
                                .cornerRadius(10) // Apply corner radius to the image
                        } placeholder: {
                            LoadingView()
                                .frame(width: 150, height: 220)
                                .cornerRadius(10)
                        }
                    }
                    .frame(width: 150, height: 220)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Colors.secondary.color().opacity(0.3), lineWidth: 1) // Add rounded border with black color
                    )
                 
                    HStack{
                        VStack(alignment:.leading){
    
                            Text(product.title)
                                .font(GilroyFonts.font(style: .thin, size: 16))
                                .foregroundColor(Colors.black.color())
                                .padding(.bottom, 2)
                            
                            Text(product.description)
                                .font(GilroyFonts.font(style: .thin, size: 14))
                                .foregroundColor(Colors.secondary.color())
                                .lineLimit(3)
                                .padding(.bottom, 6)
                            
                            HStack{
                                
                                ProductRatingView(rating: product.rating , fontStlyeRating: GilroyFonts.font(style: .thin, size: 15) , fontStlyeCount: GilroyFonts.font(style: .light, size: 0))
                          
                            }
                         
                      
   
                        }.frame(width: .infinity, height: 220)
                    }
                }
         
                HStack{
                    
                    Image(systemName: "box.truck")
                    Text("Lieferbar - \("in 2- 3 work days")")
                        .bold()
                
                        .padding(.bottom, 4)
                }.padding(.top ,5 )
                HStack{
                    Text("Verkäufer:")
                        .font(.subheadline)
                        .foregroundColor(Colors.secondary.color())
                        .padding(.bottom, 8)
                        .padding(.top, 8)
                    Text( "\("U-Store")")
                        .font(.subheadline)
                        .foregroundColor(Colors.primary.color())
                        .padding(.bottom, 8)
                        .padding(.top, 8)
                }
                VStack(alignment:.trailing) {
                
                    Text(String(format: "€ %.2f", product.price))
                        .font(.title3)
                        .bold()
                    
                    HStack{
                        
                        CustomButton(text: "Delete", textColor: Colors.white.color(), backgroundColor: Colors.secondary.color(), action: {} ,image:Image(systemName: "trash"))
                        Spacer()
                        CustomButton(text: "Add to cart", textColor: Colors.white.color(), backgroundColor: Colors.primary.color(), action: {} ,image:Image(systemName: "cart"))
                       
                    }
                }
                
            }.frame(width:.infinity , height: 400)
                .padding(10)
               //.background(.blue)
          
        }
    }
}
#Preview {
    FavoriteCart_Screen(product: .sample)
}

