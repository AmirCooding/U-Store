//
//  Notifications_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//

import SwiftUI

struct Notification: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let time: String
}

struct Notifications_Screen: View {
    let notifications: [Notification] = [
        Notification(title: "Order Shipped", message: "Your order #1234 has been shipped.", time: "2h ago"),
        Notification(title: "New Message", message: "You have a new message from customer support.", time: "1d ago"),
        Notification(title: "Update Available", message: "A new version of the app is available. Please update.", time: "3d ago")
    ]
    
    var body: some View {
        NavigationView {
            List(notifications) { notification in
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(notification.title)
                            .font(.headline)
                            .foregroundColor(.blue)
                        Spacer()
                        Text(notification.time)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text(notification.message)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Notifications")
        }
    }
}

#Preview {
    Notifications_Screen()
}
