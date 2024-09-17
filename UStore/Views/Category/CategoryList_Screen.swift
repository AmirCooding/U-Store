//
//  CategoryList_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 14.09.24.
//

import SwiftUI
struct CategoryList_Screen: View {
    var viewModel = Home_ViewModel()
    var category: ProductCategory
    @State private var searchText = ""
    @State private var showSheet = false
    @State private var isLoading = true
    
    private let gridItems = [
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        CustomSearchTextField(text: $searchText)
                        VStack {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .foregroundColor(Colors.secondary.color().opacity(0.8))
                                .font(.system(size: 25))
                                .onTapGesture {
                                    showSheet.toggle()
                                }
                                .padding()
                            
                        }
                        .sheet(isPresented: $showSheet) {
                            FilterSheet_Screen()
                            .presentationDetents([.fraction(0.6)])}
                    }
                    
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: gridItems, spacing: 15) {
                            ForEach(viewModel.productsForCategory.filter { product in
                                searchText.isEmpty ? true : product.title.localizedCaseInsensitiveContains(searchText)
                            }) { product in
                                ProductCard(product: product)
                                    .frame(width: 200, height: 320)

                            }
                        }
        
                    }
                    .overlay {
                        if viewModel.productsForCategory.isEmpty {
                            NoContentOverlay(
                                         imageURL: URL(string: "https://i.pinimg.com/736x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")!,
                                         overlayText: ""
                                     )
                        }
                    }
                    .opacity(isLoading ? 0 : 1)
                    
                }
                
                .padding(.horizontal , 20)
                .navigationTitle("\(category.title)")
                .task {
                    await viewModel.loadCategoryProducts(category: category.category.rawValue)
                    isLoading = false
                }
                
                if isLoading {
                    LoadingView()
                        .edgesIgnoringSafeArea(.all) // Make the loading view cover the entire screen
                }
            }
        
        }

    }
 
}

#Preview {
    CategoryList_Screen(category:.sampleCategory)
}
private var noContentOverlay: some View {
    Text("No Recept")
        .font(.largeTitle)
        .foregroundStyle(.gray)
}
