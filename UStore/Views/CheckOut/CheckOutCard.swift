//
//  CheckOutCard.swift
//  UStore
//
//  Created by Amir Lotfi on 30.09.24.
//

import SwiftUI

struct CheckOutCard: View {
    var product : Product
    @EnvironmentObject  var viewModel  : CheckOut_ViewModel
    var body: some View {
        HStack{
            HStack {
                AsyncImage(url: product.artworkUrl) { image in
                    image
                        .resizable()
                        .cornerRadius(10)
                } placeholder: {
                    LoadingView()
                        .cornerRadius(10)
                }
            }.frame(width: 80 , height: 120 )
                .padding(.leading,10)
            
            VStack{
                HStack{
                    Text(product.title).font(GilroyFonts.font(style: .thin, size: 16))
                        .foregroundColor(Colors.secondary.color())
                    Spacer()
                    Text(product.discountedPrice).font(GilroyFonts.font(style: .thin, size: 16))
                        .foregroundColor(Colors.secondary.color())
                }.padding()
                
                VStack{
                    HStack{
                        Text("Total Price : ").font(GilroyFonts.font(style: .thin, size: 14))
                            .foregroundColor(Colors.primary.color())
                        
                        Text("\(viewModel.subProductprice[product.id] ?? "0.00 €")")
                            .font(GilroyFonts.font(style: .bold, size: 14))
                            .bold()
                            .foregroundColor(Colors.primary.color())
                 
                        Spacer()
                        
                        Text("X \(viewModel.productQuantities[product.id] ?? 0)")
                            .font(GilroyFonts.font(style: .thin, size: 14))
                            .foregroundColor(Colors.secondary.color())
                        
                        
                        
           
                    }
                    
                    
                }.padding()
            }
        }
    }
}

#Preview {
    CheckOutCard(product: .sample)
        .environmentObject(CheckOut_ViewModel())
   
}

