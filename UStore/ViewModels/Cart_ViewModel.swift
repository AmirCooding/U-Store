//
//  cart_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 10.09.24.
//

import Foundation
import Combine
import os

@MainActor
class Cart_ViewModel : ObservableObject{
    private var repos : UStore_RepositoryImpl
    @Published var isLoading: Bool = false
    @Published var productQuantities: [Int: Int] = [:]
    @Published var cartProducts: [Product] = []
    @Published var subPrices: [Int: String] = [:]
    @Published var totalCost: String = "0.00"
    var scriptions = Set<AnyCancellable>()
    @Published var carts   = [Cart](){
        didSet{
            Task{
                try await fetchAllproductsCart()
                 calculateTotalCost()
            }
        }
    }
  
    
    init() {
        self.repos = UStore_RepositoryImpl()
        repos.carts.assign(to: \.carts , on: self).store(in: &scriptions)
    }
    // MARK: - fetch all Product from Firestore and sent to screen
    func fetchAllproductsCart() async throws {
        self.isLoading = true
        LoggerManager.logInfo("Count the cvart  in viewModel   fetch All carts: ---------------- > \(carts.count)")
        cartProducts.removeAll()
        for cart in carts {
            let product = try await repos.fetchProductById(productId: cart.ProductId)
            self.isLoading = true
            calculateQuantityPerproduct()
            cartProducts.append(product)
            self.isLoading = false
        }
        LoggerManager.logInfo("Count the cartProducts  in viewModel   fetch All Products from Cart: ---------------- > \(cartProducts.count)")
        self.isLoading = false
    }
    // MARK: - add Product to Cart
    func addToCart(productId: Int) async throws {
        if let selectedProduct = carts.first(where: { $0.ProductId == productId }) {
            let newQuantity = selectedProduct.quantity + 1
            try await repos.updateCartQuantity(productId: productId, newQuantity: newQuantity)
        } else {
            let product = try await repos.fetchProductById(productId: productId)
            try  repos.createCart(product: product)
        }
    }

    // MARK: - calculate Quantity Per Product
    func calculateQuantityPerproduct() {
        productQuantities.removeAll()
        for cart in carts {
            if let quantity = productQuantities[cart.ProductId] {
                productQuantities[cart.ProductId] = quantity + cart.quantity
            } else {
                productQuantities[cart.ProductId] = cart.quantity
            }
        }
    }
    
    // MARK: - calculate Total Sub Price
    func calculateSubPrice(for productId: Int) {
        if let cart = carts.first(where: { $0.ProductId == productId }) {
            let totalSubPrice = cart.productPrice * Double( cart.quantity)
            subPrices[productId] = String(format: "%.2f €", totalSubPrice)
        }
    }
    
    // MARK: - calculate Total Cost Price
    func calculateTotalCost(){
        var totalCost: Double = 0.0
        for cartItem in carts {
            let productTotal = cartItem.productPrice * Double(cartItem.quantity)
            let shippingCost = cartItem.isFreeShgiping ? 0.0 : cartItem.deliveryPrice
            totalCost += productTotal + shippingCost
        }
        self.totalCost = String(format: "%.2f €", totalCost)
    }

    // MARK: - Fetch product details for a given productId
    func fetchProductById(productId: Int) async throws -> Product {
        return try await repos.fetchProductById(productId: productId)
    }
    // MARK: - Delete a cart from favorites
    func deleteCart(cart: Cart) async throws {
        guard let currentQuantity = productQuantities[cart.ProductId], currentQuantity > 0 else {
            return
        }
        productQuantities[cart.ProductId] = currentQuantity - 1
        if productQuantities[cart.ProductId] == 0 {
            try await repos.deleteCart(cart: cart)
            productQuantities.removeValue(forKey: cart.ProductId)
        }
    }
    
    func deleteCartByProductId(productId: Int) async throws {
        if let cart = FFCartManager.shared.carts.first(where: { $0.ProductId == productId }) {
                try await repos.deleteCart(cart: cart)
        }
    }
    
    func deleteProductCartByProductId(productId: Int) async throws {
        if let cart = FFCartManager.shared.carts.first(where: { $0.ProductId == productId }) {
            if cart.quantity > 1 {
                let newQuantity = cart.quantity - 1
                try await repos.updateCartQuantity(productId: productId, newQuantity: newQuantity)
            } else {
                try await repos.deleteCart(cart: cart)
            }
        }
    }


}


