//
//  Cart_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct Cart_Screen: View {
    @EnvironmentObject private var viewModel  : Cart_ViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    if viewModel.cartProducts.isEmpty{
                        NoContentOverlay(
                            imageURL: URL(string: "https://i.pinimg.com/736x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")!,
                            overlayText: ""
                        )
                    }
                }
                ScrollView {
               
                    VStack {
                        ForEach(viewModel.cartProducts) { product in
                            CartCard_Screen(product: product)
                        }
                    }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Cart")
                            .font(GilroyFonts.font(style: .semiBold, size: 18))
                    }
                }
            
            }
        }.onAppear{
            Task{
               try await viewModel.fetchAllproductsCart()
            }
        }
        
            if viewModel.isLoading && viewModel.cartProducts.isEmpty{
            LoadingView()
                .edgesIgnoringSafeArea(.all)
        }
            
    }
}


#Preview {
    Cart_Screen()
        .environmentObject(Cart_ViewModel())
}
