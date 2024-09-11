//
//  Favorite_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct Favorite_Screen: View {
    private var viewModel = Favorite_ViewModel()
    var body: some View {
        NavigationStack{
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Faivorite")
                        .font(GilroyFonts.font(style: .semiBold, size: 18))
                }
            }
            .overlay {
                if viewModel.favorites.isEmpty {
                    NoContentOverlay(
                        imageURL: URL(string: "https://i.pinimg.com/736x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")!,
                        overlayText: ""
                    )
                }
            }
      
        }
    }
}

#Preview {
    Favorite_Screen()
}

