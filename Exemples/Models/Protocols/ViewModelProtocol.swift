//
//  ViewModelProtocol.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import Foundation
import NavigationModule

protocol ViewModelProtocol { }

extension ViewModelProtocol {
    
    var router: Router<AppDestination>? {
        let currentFlow = AppRouterManager.shared.selectedFlow
        return AppRouterManager.shared.getRouter(for: currentFlow)
    }
    
}
