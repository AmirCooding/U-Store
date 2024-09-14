//
//  Favorite_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct Favorite_Screen: View {
    @StateObject private var viewModel = Favorite_ViewModel()
  
    var body: some View {
      
       
            NavigationStack {
                ZStack {
                    if viewModel.favoriteProducts.isEmpty{
        
                        NoContentOverlay(
                            imageURL: URL(string: "https://i.pinimg.com/736x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")!,
                            overlayText: "No favorites yet!"
                        )
                    }
                    ScrollView {
                        VStack {
                            ForEach(viewModel.favoriteProducts) { product in
                                FavoriteCart_Screen(product: product)
                            }
                        }
                 
                    }
                    .onAppear {
                        Task {
                            try await viewModel.fetchFavoritesAndProducts()
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Favorite")
                                .font(GilroyFonts.font(style: .semiBold, size: 18))
                        }
                    }
                    if viewModel.isLoading {
                        LoadingView()
                            .edgesIgnoringSafeArea(.all)
                    }
                }
                }
            }

         
}

#Preview {
    Favorite_Screen()
}
