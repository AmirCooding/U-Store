//
//  Cart_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct Cart_Screen: View {
    @StateObject private var viewModel = Cart_ViewModel()
    @State private var navigateToCheckout = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if viewModel.cartProducts.isEmpty {
                        NoContentOverlay(
                            imageURL: URL(string: "https://i.pinimg.com/736x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")!,
                            overlayText: ""
                        )
                    }
                }

                VStack {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.cartProducts) { product in
                                CartCard_Screen(product: product)
                            }
                        }
                    }
                    Spacer()

                    // Show the entire HStack (Total price and Checkout button) only if there are products in the cart
                    if !viewModel.cartProducts.isEmpty {
                        HStack {
                            HStack {
                                Text("Total : ").font(GilroyFonts.font(style: .bold, size: 16))
                                Text("\(viewModel.totalCost)").font(GilroyFonts.font(style: .bold, size: 17))
                                    .foregroundColor(Colors.primary.color())
                            }
                            .padding(.horizontal, 30)

                            Spacer()

                            HStack {
                                NavigationLink(destination: CheckOut_Screen(), isActive: $navigateToCheckout) {
                                    CustomButton(
                                        text: "Checkout",
                                        textColor: Colors.white.color(),
                                        backgroundColor: Colors.primary.color(),
                                        action: {
                                            navigateToCheckout = true
                                        }
                                    )
                                }
                            }
                            .frame(width: 120, height: 60)
                            .padding()
                        }
                        .background(Colors.secondary.color().opacity(0.07))
                        .padding(.bottom, 2)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Cart")
                            .font(GilroyFonts.font(style: .semiBold, size: 18))
                    }
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchAllproductsCart()
            }
        }

        if viewModel.isLoading {
            LoadingView()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    Cart_Screen()
}
