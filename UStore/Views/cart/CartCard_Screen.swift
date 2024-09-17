//
//  CartCard_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 14.09.24.
//

import SwiftUI

struct CartCard_Screen: View {
    var product : Product
    @StateObject private var viewModel = Cart_ViewModel()
    @State private var showAlert = false

    var body: some View {
        ZStack(alignment:.trailingLastTextBaseline){
            Button(action: {
                         showAlert = true
                     }) {
                         Image(systemName: "multiply.circle.fill")
                             .resizable()
                             .frame(width: 24, height: 24)
                             .foregroundColor(Colors.error.color().opacity(0.7))
                             .padding(.bottom, 100)
                     }
                     .alert(isPresented: $showAlert) {
                         Alert(
                             title: Text("Delete Product"),
                             message: Text("Are you sure you want to delete this product from the cart?"),
                             primaryButton: .destructive(Text("Delete")) {
                                 Task {
                                     try await viewModel.deleteCartByProductId(productId:product.id)
                                 }
                             },
                             secondaryButton: .cancel()
                         )
                     }
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
                        Text(product.title).font(GilroyFonts.font(style: .thin, size: 14))
                            .foregroundColor(Colors.secondary.color())
                        Spacer()
                        Text(product.discountedPrice).font(GilroyFonts.font(style: .thin, size: 14))
                            .foregroundColor(Colors.secondary.color())
                    }.padding(.top , 15)
                    Spacer()
                    
                    VStack{
                        HStack{
                            Text("Seller : UStore").font(GilroyFonts.font(style: .thin, size: 12))
                                .foregroundColor(Colors.secondary.color())
                            Spacer()
                            Text("x \(viewModel.productQuantities[product.id] ?? 0)").font(GilroyFonts.font(style: .thin, size: 12))
                                .foregroundColor(Colors.secondary.color())
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                
                                Task{
                                  try await  viewModel.deleteProductCartByProductId(productId: product.id)
                                }
                              
                            }) {
                                Image(systemName: "minus.square.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Colors.primary.color())
                            }
                            Text("\(viewModel.productQuantities[product.id] ?? 0)")
                                .font(GilroyFonts.font(style: .thin, size: 20))
                                .foregroundColor(Colors.secondary.color())
                            
                            Button(action: {
                                Task{
                                     try await viewModel.addToCart(productId:product.id)
                                }
                            }) { Image(systemName: "plus.app.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Colors.primary.color())
                            }
                            Spacer()
                            
                            Text("\(viewModel.subPrices[product.id] ?? "0.00 €")")
                                .font(GilroyFonts.font(style: .bold, size: 20))
                                .bold()
                                .foregroundColor(Colors.primary.color())
                        }.padding(.bottom, 20)

                        
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 130)
            .background(Colors.secondary.color().opacity(0.04))
            .cornerRadius(12)
        }.padding(.horizontal)
            .onAppear{
                Task {
                    viewModel.calculateSubPrice(for: product.id)
                }
            }
        
        
    }
}

#Preview {
    CartCard_Screen(product: .sample)
        
}
