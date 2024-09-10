//
//  ProductDetails_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import SwiftUI

struct ProductDetails_Screen: View {
    let product: Product
    @State private var isFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ProductImageView(url: product.artworkUrl)
                    ProductTitleAndFavoriteView(product: product, isFavorite: $isFavorite)
                    ProductCategoryView(category: product.category)
                    ProductPriceView(product: product)
                    ProductDescriptionView(description: product.description)
                    ProductRatingView(rating: product.rating)
                    AddToBasketButton()
                }
                .padding(.vertical)
            }
            .navigationTitle("Product Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Subviews

struct ProductImageView: View {
    let url: URL?
    
    var body: some View {
        if let url = url {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .padding(.horizontal)
        }
    }
}

struct ProductTitleAndFavoriteView: View {
    let product: Product
    @Binding var isFavorite: Bool
    
    var body: some View {
        HStack {
            Text(product.title)
                .font(GilroyFonts.font(style: .bold, size: 26))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            
            Spacer()
            
            Button(action: {
                isFavorite.toggle()
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
                    .font(.title)
            }
        }
        .padding(.horizontal)
    }
}

struct ProductCategoryView: View {
    let category: Category
    
    var body: some View {
        Text("Category: \(category.rawValue.capitalized)")
            .font(GilroyFonts.font(style: .thin, size: 16))
            .foregroundColor(.gray)
            .padding(.horizontal)
    }
}

struct ProductPriceView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(product.discountedPrice)
                .font(GilroyFonts.font(style: .semiBold, size: 22))
                .fontWeight(.bold)
            
            Text("\(product.originalPrice)")
                .font(.subheadline)
                .strikethrough()
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

struct ProductDescriptionView: View {
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.headline)
            
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

struct ProductRatingView: View {
    let rating: Rating
    
    var body: some View {
        HStack {
            Text("Rating: \(String(format: "%.1f", rating.rate!))")
                .font(.headline)
            
            
            Spacer()
            
            HStack(spacing: 4) {
                ForEach(0..<5) { index in
                    Image(systemName: index < Int(rating.rate!.rounded()) ? "star.fill" : "star")
                        .foregroundColor(index < Int(rating.rate!.rounded()) ? .yellow : .gray)
                }
            }
            
            if let count = rating.count {
                Text("(\(count) reviews)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Text("(No reviews)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
}


struct AddToBasketButton: View {
    var body: some View {
        CustomButton(text: "Add to Cart", textColor: Colors.white.color(), backgroundColor: Colors.primary.color(), action: {})
            .padding()
    }
}

// Preview

#Preview {
    ProductDetails_Screen(product: .sample)
}
