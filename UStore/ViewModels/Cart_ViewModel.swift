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
    @Published var isLoading: Bool = false
    private var repos : UStore_RepositoryImpl
    @Published var productQuantities: [Int: Int] = [:]
    @Published var cartProducts: [Product] = []
    @Published var subPrices: [Int: String] = [:]
    var carts: [Cart] {
        repos.carts
    }
    init() {
        self.repos = UStore_RepositoryImpl()
    }
    // MARK: - fetch all Product from Firestore and sent to screen
    func fetchAllproductsCart() async throws {
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
    // MARK: - calculate Total Sub Price
    func calculateSubPrice(for productId: Int) {
        let quantity = productQuantities[productId] ?? 0
        if let cart = carts.first(where: { $0.ProductId == productId }) {
            let totalSubPrice = cart.productPrice * Double(quantity)
            subPrices[productId] = String(format: "%.2f €", totalSubPrice)
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
/*
    // MARK: - Delete a product from favorites by its productId
    func deleteCartByProductId(productId: Int) async throws {
        LoggerManager.logInfo("Trying to delete cart with ProductId: \(productId)")
        for cart in carts {
            LoggerManager.logInfo("Existing favorite ProductId: \(cart.ProductId)")
        }
        if let cart = carts.first(where: { $0.ProductId == productId }) {
            LoggerManager.logInfo("------------------------ Found cart! --------------------")
            try await deleteCart(cart: cart)
            try await repos.updateCartQuantity(productId: productId, newQuantity: newQuantity)

        } else {
            LoggerManager.logInfo("------------------------ No cart Found --------------------")
        }
    }
*/

}


