//
//  Navigator_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI


struct Navigatoreator_Screen: View {
    @StateObject  var cartViewModel  = Cart_ViewModel()
    @StateObject  var favoriteViewModel  = Favorite_ViewModel()
    var body: some View {
        TabView {
            Home_Screen()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            
            Explore_Screen()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }

          
            Cart_Screen()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
               .badge(cartViewModel.calculateQuantityAllProducts())

            Favorite_Screen()
                .tabItem {
                    Label("Favorite", systemImage: "heart.fill")
                }
                .badge(favoriteViewModel.favorites.count)

       
            Account_Screen()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
        .accentColor(Colors.primary.color())
    }
}

#Preview {
    Navigatoreator_Screen()

}

