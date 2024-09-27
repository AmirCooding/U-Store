//
//  PromoCard_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//

import SwiftUI

struct PromoCard: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let actionText: String
}

struct PromoCard_Screen: View {
    let promoCards: [PromoCard] = [
        PromoCard(title: "Summer Sale", description: "Get 50% off on all items in our summer collection.", imageName: "sun.max.fill", actionText: "Shop Now"),
        PromoCard(title: "New Arrivals", description: "Check out the latest trends in our new arrivals.", imageName: "sparkles", actionText: "Explore"),
        PromoCard(title: "Exclusive Offer", description: "Join our loyalty program and enjoy exclusive discounts.", imageName: "gift.fill", actionText: "Join Now")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(promoCards) { card in
                    PromoCardView(card: card)
                }
            }
            .padding()
        }
        .navigationTitle("Promotions")
    }
}

struct PromoCardView: View {
    let card: PromoCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Image
            Image(systemName: card.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)

    
            Text(card.title)
                .font(.headline)
                .foregroundColor(.primary)

          
            Text(card.description)
                .font(.body)
                .foregroundColor(.secondary)

            CustomButton(text: card.actionText, textColor: Colors.white.color(), backgroundColor: Colors.primary.color(), action: {})
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    PromoCard_Screen()
}
