//
//  ContentView.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import SwiftUI
import NavigationModule

struct ContentView: View {
    
    @StateObject private var appRouterManager: AppRouterManager = .shared
    
    @StateObject private var profileRouter: Router<AppDestination> = .init()
    @StateObject private var randomRouter: Router<AppDestination> = .init()
    
    @State private var personStore: PersonStore = .shared
    
    var body: some View {
        VStack(spacing: 0) {
            FlowBannerView(flow: appRouterManager.selectedFlow)
            
            TabView(selection: $appRouterManager.selectedFlow) {
                NavigationStackView(
                    router: profileRouter,
                    routerManager: appRouterManager,
                    flow: AppFlow.profileList,
                    destinationContent: { AppDestination.content(for: $0) }
                ) {
                    ProfileListScreen()
                }
                .tabItem { Label("Persons", systemImage: "cat") }
                
                NavigationStackView(
                    router: randomRouter,
                    routerManager: appRouterManager,
                    flow: AppFlow.random,
                    destinationContent: { AppDestination.content(for: $0) }
                ) {
                    RandomNumberScreen()
                }
                .tabItem { Label("Random", systemImage: "questionmark") }
            }
        }
        .environmentObject(appRouterManager)
        .environment(personStore)
    }
}

#Preview {
    ContentView()
}
