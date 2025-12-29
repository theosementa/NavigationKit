//
//  AppRouterManager.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import Foundation
import NavigationModule

final class AppRouterManager: RouterManager<AppFlow, AppDestination> {
    static let shared: AppRouterManager = .init()
    
    init() {
        super.init(selectedFlow: .profileList)
    }
    
}
