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
    @State private var filteredProducts: [Product] = []

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
                            // Pass the filtered products list to the filter sheet
                            FilterSheet_Screen(viewModel: viewModel, category: category.category.rawValue, filteredProducts: $filteredProducts)
                                .presentationDetents([.fraction(0.6)])
                        }
                    }

                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: gridItems, spacing: 15) {
                            ForEach(filteredProducts.filter { product in
                                searchText.isEmpty ? true : product.title.localizedCaseInsensitiveContains(searchText)
                            }) { product in
                                ProductCard(product: product)
                                    .frame(width: 200, height: 320)
                            }
                        }
                    }
                    .overlay {
                        if filteredProducts.isEmpty && !isLoading {
                            NoContentOverlay(
                                imageURL: URL(string: "https://i.pinimg.com/736x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")!,
                                overlayText: ""
                            )
                        }
                    }
                    .opacity(isLoading ? 0 : 1)
                }
                .padding(.horizontal, 20)
                .navigationTitle("\(category.title)")
                .task {
                    // Load products for category initially
                  await viewModel.loadCategoryProducts(category: category.category.rawValue)
                    filteredProducts = viewModel.productsForCategory
                    isLoading = false
                }

                if isLoading {
                    LoadingView()
                        .edgesIgnoringSafeArea(.all)
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
