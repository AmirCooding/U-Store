//
//  ContentView.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Crash") {
              fatalError("Crash was triggered")
            }
    
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
