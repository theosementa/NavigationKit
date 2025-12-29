//
//  CustomNavigationStack.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//

import SwiftUI
import NavigationKit

struct ContentView: View {
    
    @StateObject private var appRouterManager: AppRouterManager = .init()
    @StateObject private var catRouter: Router<AppDestination> = .init()
    @StateObject private var randomRouter: Router<AppDestination> = .init()
    
    var body: some View {
        TabView(selection: $appRouterManager.selectedFlow) {
            NavigationStackView(
                router: catRouter,
                destinationContent: { AppDestination.content(for: $0) }
            ) {
                CatFactScreen()
            }
            .tabItem { Label("Cat fact", systemImage: "cat") }
            .tag(AppFlow.cat)
            
            NavigationStackView(
                router: randomRouter,
                destinationContent: { AppDestination.content(for: $0) }
            ) {
                RamdomNumberScreen()
            }
            .tabItem { Label("Random", systemImage: "questionmark") }
            .tag(AppFlow.random)
        }
        .environmentObject(appRouterManager)
    }
    
}
