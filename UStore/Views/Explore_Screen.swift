//
//  Explore_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//
import Foundation
import SwiftUI
struct Explore_Screen: View {
    @State private var searchQuery: String = ""
    private var viewModel = Explore_ViewModel()
    private let gridItems = [
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomSearchTextField(text: $searchQuery)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 5) {
                        ForEach(viewModel.filterProductsByTitle(searchText: searchQuery, products: viewModel.products)) { product in
                            ProductCard(product: product)
                                .frame(width: 200, height: 320) // Adjust height of each product card
                        }
                    }
                    .padding()
                }
            }
         
            .overlay {
                if viewModel.products.isEmpty {
                    NoContentOverlay(
                        imageURL: URL(string: "https://i.pinimg.com/736x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")!,
                        overlayText: ""
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Explore")
                        .font(GilroyFonts.font(style: .semiBold, size: 18))
                }
            }
        }
    }
}

#Preview {
    Explore_Screen()
}
