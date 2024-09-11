//
//  Cart_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct Cart_Screen: View {
    private var viewModel = Cart_ViewModel()
    var body: some View {
        NavigationStack{
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Cart")
                        .font(GilroyFonts.font(style: .semiBold, size: 18))
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
      
        }
    }
}


#Preview {
    Cart_Screen()
}
