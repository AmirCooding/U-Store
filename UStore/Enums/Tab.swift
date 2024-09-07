//
//  Tab.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//


import SwiftUI

enum Tab: String, Identifiable, CaseIterable {
    case home,explore, cart, favorite, account
    
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .explore: return "Explore"
        case .cart: return "Cart"
        case .favorite: return "Favorite"
        case .account: return "Account"
   
        }
    }

    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .explore: return "magnifyingglass"
        case .cart: return "cart.fill"
        case .favorite: return "heart.fill"
        case .account: return "person.fill"
        }
    }
    
    var view: AnyView {
        switch self {
        case .home: return AnyView(Home_Screen())
        case .explore: return AnyView(Explore_Screen())
        case .favorite: return AnyView(Favorite_Screen())
        case .cart: return AnyView(Cart_Screen())
        case .account: return AnyView(Account_Screen())

        
        }
    }
}

