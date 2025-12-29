//
//  ProfileDetailsScreen+ViewModel.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import Foundation
import NavigationModule

extension ProfileDetailsScreen {
    
    @Observable
    final class ViewModel: ViewModelProtocol {
        
        let userId: String
        
        init(userId: String) {
            self.userId = userId
        }
        
    }
    
}

extension ProfileDetailsScreen.ViewModel {

    func onTapPushFullName() {
        router?.push(.profile(.fullName(userId: userId)))
    }
    
    func onTapBottomSheetFullName() {
        router?.present(route: .sheet(style: .medium), .profile(.fullName(userId: userId)))
    }
    
    func onTapFitSheetFullName() {
        router?.present(route: .sheet(style: .fitContent), .profile(.fullName(userId: userId)))
    }
    
}
