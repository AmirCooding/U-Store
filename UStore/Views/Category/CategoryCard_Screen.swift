//
//  CategoryCard_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 14.09.24.
//

import Foundation
import SwiftUI

struct CategoryCard_Screen: View {
    let category: ProductCategory

    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink(destination: CategoryList_Screen(category: category)) {
                        Image(category.image)
                            .resizable()
                          
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .cornerRadius(10)
                            .clipped()
                        
                }
                .buttonStyle(PlainButtonStyle())
                .cornerRadius(20)
                .frame(width: .infinity , height: 200)
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    CategoryCard_Screen(category: .sampleCategory)
}
