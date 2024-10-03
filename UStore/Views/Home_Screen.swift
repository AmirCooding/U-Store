//
//  Home_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct Home_Screen: View {
    @State private var searchQuery: String = ""
    var viewModel = Home_ViewModel()
    @State private var selectedCategory: Category?
    
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false){
                VStack(spacing: 20) {
                    
                    Image("logo_image")
                        .resizable()
                        .frame(width: 200, height: 60)
                        .padding(.top ,30)
                        .padding(.bottom ,10)
                    HStack{
                        TabView {
                            ForEach(viewModel.categories, id: \.id) { category in
                            
                                    CategoryCard_Screen(category: category)
                                
                            }
                        }
                      
                    }.frame( width: .infinity , height: 200)
                        .cornerRadius(10)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    
                    
                    // Exclusive Offer Header
                    HStack {
                        Text("BestSeller")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            // Action for see all
                        }) {
                            Text("See All")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(viewModel.bestSeller, id: \.id) { offer in
                                ProductCard(product: offer)
                                
                            }.padding(.leading ,10)
                        }
                        
                    }
                    
                    HStack {
                        Text("Popular ")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            // Action for see all
                        }) {
                            Text("See All")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.populerProducts, id: \.id) { offer in
                                ProductCard(product: offer)
                                
                            }.padding(.leading, 10)
                        }
                        
                    }
                }
                .padding(.bottom, 10)
                
            }

        
        }
        
    }
    
}



#Preview {
    Home_Screen()
}
