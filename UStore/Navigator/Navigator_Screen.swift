//
//  Navigator_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct Navigatoreator_Screen: View {
   // @StateObject  var favoriteViewModel  = Favorite_ViewModel()
   // @StateObject  var cartViewModel  = Cart_ViewModel()
    var body: some View {
        TabView {
            ForEach(Tab.allCases) { tab in
                tab.view
                    .tabItem {
                        Label(tab.title, systemImage: tab.icon)
                    }
                    .tag(tab)
            }
       }
        .accentColor(Colors.primary.color())
     //   .environmentObject(favoriteViewModel)
     //   .environmentObject(cartViewModel)
        
        
    }
}

#Preview {
    Navigatoreator_Screen()
}
