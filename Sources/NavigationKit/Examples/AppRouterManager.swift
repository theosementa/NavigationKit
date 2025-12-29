//
//  AppRouterManager.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//

import Foundation
import NavigationKit

public final class AppRouterManager: RouterManager<AppFlow, String> {
    
}

//public final class AppRouterManager: ObservableObject {
//
//    @Published public var selectedTab: AppTabs = .cat
//    private var routers: [AppTabs: Router<AppDestination>] = [:]
//
//    public init() { }
//}
//
//public extension AppRouterManager {
//
//    func register(router: Router<AppDestination>, for tab: AppTabs) {
//        return routers[tab] = router
//    }
//
//    func router(for tab: AppTabs) -> Router<AppDestination>? {
//        return routers[tab]
//    }
//
//}
//
//public extension AppRouterManager {
//
//    @MainActor
//    func navigateToTab(_ tab: AppTabs, then: @escaping () -> Void) {
//        self.selectedTab = tab
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            then()
//        }
//    }
//
//    @MainActor
//    func navigateToFruitDetailSheet() { // Example
//        navigateToTab(.cat) {
//            self.router(for: .cat)?.push(.profile(.profile(userId: "jgzzzdz")))
//        }
//    }
//
//}
