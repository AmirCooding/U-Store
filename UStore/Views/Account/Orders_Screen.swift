//
//  Orders_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//

import SwiftUI


struct Orders_Screen: View {
    let orders: [Order] = [
        Order(itemName: "Laptop", orderDate: "2024-08-21", orderStatus: "Shipped"),
        Order(itemName: "Smartphone", orderDate: "2024-08-22", orderStatus: "Processing"),
        Order(itemName: "Headphones", orderDate: "2024-08-23", orderStatus: "Delivered")
    ]
    
    var body: some View {
        NavigationView {
            List(orders) { order in
                HStack {
                    VStack(alignment: .leading) {
                        Text(order.itemName)
                            .font(.headline)
                        Text("Order Date: \(order.orderDate)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(order.orderStatus)
                        .font(.subheadline)
                        .foregroundColor(order.orderStatus == "Delivered" ? .green : .blue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(order.orderStatus == "Delivered" ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("Orders")
        }
    }
}

#Preview {
    Orders_Screen()
}
