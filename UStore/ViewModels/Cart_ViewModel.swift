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
    @Published var carts   = [CartItem](){
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
    var scriptions = Set<AnyCancellable>()
    // MARK: - fetch all Product from Firestore and sent to screen -
    func fetchAllproductsCart() async throws {
        cartProducts.removeAll()
        self.isLoading = true
        do {
            for cart in carts {
                let product = try await repos.fetchProductById(productId: cart.ProductId)
                DispatchQueue.main.async {
                    self.cartProducts.append(product)
                    self.calculateQuantityPerproduct()
                }
            }
        } catch {
            LoggerManager.logInfo("Failed to fetch products: \(error)")
            throw error
        }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        LoggerManager.logInfo("Count the cartProducts in viewModel fetch All Products from Cart: ---------------- > \(cartProducts.count)")
    }

    // MARK: - add Product to Cart -
    func calculateQuantityAllProducts() -> Int {
        var quantities = 0
        for cart in carts{
            quantities += cart.quantity
        }
    return quantities
    }
    
    // MARK: - add Product to Cart -
    func addToCart(productId: Int) async throws {
        if let selectedProduct = carts.first(where: { $0.ProductId == productId }) {
            let newQuantity = selectedProduct.quantity + 1
            try await updateCartQuantity(productId: productId, newQuantity: newQuantity)
        } else {
           let product = try await repos.fetchProductById(productId: productId)
            try  repos.createCart(product: product)
          //  try  repos.createCart(productId: productId)
        }
    }
    
    func updateCartQuantity(productId: Int, newQuantity: Int) async throws {
        try await repos.updateCartQuantity(productId: productId, newQuantity: newQuantity)
    }

    // MARK: - calculate Quantity Per Product -
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
    
    // MARK: - calculate Total Sub Price -
    func calculateSubPrice(for productId: Int) {
        if let cart = carts.first(where: { $0.ProductId == productId }) {
            let totalSubPrice = cart.productPrice * Double( cart.quantity)
            subPrices[productId] = String(format: "%.2f €", totalSubPrice)
        }
    }
    
    // MARK: - calculate Total Cost Price -
    func calculateTotalCost(){
        var totalCost: Double = 0.0
        for cartItem in carts {
            let productTotal = cartItem.productPrice * Double(cartItem.quantity)
            let shippingCost = cartItem.isFreeShgiping ? 0.0 : cartItem.deliveryPrice
            totalCost += productTotal + shippingCost
        }
        self.totalCost = String(format: "%.2f €", totalCost)
    }

    // MARK: - Fetch product details for a given productId -
    func fetchProductById(productId: Int) async throws -> Product {
        return try await repos.fetchProductById(productId: productId)
    }
    // MARK: - Delete a cart from favorites -
    func deleteCart(cart: CartItem) async throws {
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


