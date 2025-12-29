//
//  ProfileListScreen+ViewModel.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import Foundation
import NavigationModule

extension ProfileListScreen {
    
    @Observable
    final class ViewModel: ViewModelProtocol {
        
    }
    
}

extension ProfileListScreen.ViewModel {
    
    func onTapDetail(userId: String) {
        router?.present(route: .fullScreenCover, .profile(.details(userId: userId)))
    }
    
}
