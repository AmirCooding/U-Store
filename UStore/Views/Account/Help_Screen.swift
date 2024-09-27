//
//  Help_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 18.09.24.
//

import SwiftUI

struct Help_Screen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                Text("Help & Support")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                // Introduction
                Text("Need help? We’re here to assist you with any questions or issues you might have. Below are some frequently asked questions and ways to get in touch with us.")
                    .font(.body)
                    .padding(.bottom, 10)

                // FAQ Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Frequently Asked Questions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Group {
                        FAQItem(question: "How do I reset my password?", answer: "To reset your password, go to the settings page, tap on 'Account', and select 'Reset Password'.")
                        
                        FAQItem(question: "How can I contact support?", answer: "You can contact support by tapping the 'Contact Support' button below or by emailing us at support@yourcompany.com.")
                        
                        FAQItem(question: "Where can I find the user manual?", answer: "The user manual is available in the app under 'Help' or on our website.")
                    }
                }

                CustomButton(text: "Contact Support", textColor: Colors.white.color(), backgroundColor: Colors.primary.color() , action: {}).padding(.top,50)

                Spacer()
            }
            .padding(.horizontal, 30)
        }
        .navigationTitle("Help")
    }
}

struct FAQItem: View {
    let question: String
    let answer: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(question)
                .font(.headline)
                .foregroundColor(.blue)
            Text(answer)
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    Help_Screen()
}
