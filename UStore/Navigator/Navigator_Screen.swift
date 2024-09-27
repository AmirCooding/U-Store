//
//  Navigator_Screen.swift
//  UStore
//
//  Created by Amir Lotfi on 06.09.24.
//

import SwiftUI

struct Navigatoreator_Screen: View {

    var body: some View {
        TabView {
            ForEach(Tab.allCases) { tab in
                tab.view
                    .tabItem {
                        Label(tab.title, systemImage: tab.icon)
                    }
                    .tag(tab)
                    .badge(tab.badgeCount > 0 ? tab.badgeCount : 0)
            }
        }
        .accentColor(Colors.primary.color())
    }
}

#Preview {
    Navigatoreator_Screen()
}
