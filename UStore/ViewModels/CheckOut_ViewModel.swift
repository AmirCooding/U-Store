//
//  CheckOut_ViewModel.swift
//  UStore
//
//  Created by Amir Lotfi on 01.10.24.
//

import Foundation
import Combine
@MainActor
class CheckOut_ViewModel : ObservableObject{
    private var repos : UStore_RepositoryImpl
    @Published var profile = UserProfile()
    @Published var productQuantities: [Int: Int] = [:]
    @Published var cartProducts: [Product] = []
    @Published var subProductprice: [Int: String] = [:]
    @Published var subPrice: String = "0.00"
    @Published var deliveryDate: String = ""
    @Published var calculateAllProducts: Int = 0
    @Published var calculateSavedMonay: String = "0.00"
    @Published var totalPrice: String = "0.00"
    
    var scriptions = Set<AnyCancellable>()
    @Published var carts   = [CartItem](){
        didSet{
            Task{
                try await addAllProductToCheckOut()
                calculateTotalCost()
            }
        }
    }

    init() {
        self.repos = UStore_RepositoryImpl()
        repos.carts.assign(to: \.carts , on: self).store(in: &scriptions)
        repos.userProfile
            .receive(on: DispatchQueue.main)
            .assign(to: \.profile, on: self)
            .store(in: &scriptions)
        Task{
            try await  fetchUserProfile()
        }
        
        calculateNumbersofallProduct()
        getDeliveryDateRange()
        calculateSaveMonay()
        calculateTotalCost()
    }
    // MARK: - fetch all Product from Firestore and sent to screen -
  
    func addAllProductToCheckOut() async throws {
        cartProducts.removeAll()
        do {
            for cart in carts {
                let product = try await repos.fetchProductById(productId: cart.ProductId)
                DispatchQueue.main.async {
                    self.cartProducts.append(product)
                    self.calculateQuantityPerproduct()
                    self.calculateSubPrice(for: product.id)
                }
            }
        } catch {
            LoggerManager.logInfo("Failed to fetch products: \(error)")
            throw error
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
            subProductprice[productId] = String(format: "%.2f €", totalSubPrice)
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
        self.totalPrice = String(format: "%.2f €", totalCost + 5.99)
        self.subPrice = String(format: "%.2f €", totalCost)
    }
    
    
    // MARK: - calculate Total Cost Price -
   
    func calculateSaveMonay(){
        var totalCost: Double = 0.0
        for cartItem in carts {
            let productTotal = cartItem.productPrice * Double(cartItem.quantity)
            let shippingCost = cartItem.isFreeShgiping ? 0.0 : cartItem.deliveryPrice
            totalCost += productTotal + shippingCost
        }
        
        self.calculateSavedMonay = String(format: "%.2f €", totalCost * 0.2)
    }

    // MARK: - Fetch product details for a given productId -
   
    func fetchProductById(productId: Int) async throws -> Product {
        return try await repos.fetchProductById(productId: productId)
    }
  
    // MARK: - Fetch profile-
    func fetchUserProfile() async throws {
        do{
         try await repos.fetchUserProfile()
        }catch{
            LoggerManager.logMessageAndError("Can  not fetch Profile Details ", error: HttpError.requestFailed)
            
        }
        
    }
    
    // MARK: - Clculate Quantieties of Products -
    func calculateNumbersofallProduct(){
        for cart in carts{
            self.calculateAllProducts += cart.quantity
        }
    }
    
    // MARK: - Check Address Is or Not Empty -
    func chckAddressISNotEmpty() -> Bool {
        if profile.fullName.isEmpty ||
           profile.userAddress.street.isEmpty ||
           profile.userAddress.number.isEmpty ||
           profile.userAddress.city.isEmpty ||
           profile.userAddress.zipCode.isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - Check Payment Is or Not Empty -
    func chckPaymentISNotEmpty()-> Bool{
        if profile.paymentMethode.creditCard.creditCartIssClicked || profile.paymentMethode.payPal.payPalisClicked || profile.paymentMethode.sepa.sepaClicked{
            return true
        }
        return false
    }
  

    func getDeliveryDateRange()  {
        let calendar = Calendar.current
        let today = Date()
        
        // Hilfsfunktion, um zu prüfen, ob ein Datum ein Werktag ist
        func isWeekday(_ date: Date) -> Bool {
            let weekday = calendar.component(.weekday, from: date)
            return weekday >= 2 && weekday <= 6
        }
        
        // Nächster Werktag ab dem aktuellen Datum finden
        func addWorkingDays(_ days: Int, to date: Date) -> Date {
            var workingDaysAdded = 0
            var currentDate = date
            
            while workingDaysAdded < days {
                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
                if isWeekday(currentDate) {
                    workingDaysAdded += 1
                }
            }
            return currentDate
        }
        
        // 4 und 6 Werktage ab heute berechnen
        let startDate = addWorkingDays(4, to: today)
        let endDate = addWorkingDays(6, to: today)
        
        // Datum formatieren
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "de_DE")
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        // Rückgabe der Formatierung: "4. Okt. bis 6. Okt."
        self.deliveryDate = "\(startDateString) - \(endDateString)"
    }

}
