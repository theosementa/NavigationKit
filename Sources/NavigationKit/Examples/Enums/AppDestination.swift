//
//  AppDestination.swift
//  NavigationModule
//
//  Created by Fabrice Ortega on 17/06/2025.
//

import SwiftUI
import NavigationKit

public enum AppDestination: AppDestinationProtocol {
    case profile(ProfileDestination)
    case cat(CatDestination)
}

extension AppDestination {
    
    @ViewBuilder
    static func content(for destination: AppDestination) -> some View {
        switch destination {
        case .profile(let profile):
            destinationProfile(profile)
        case .cat(let cat):
            destinationCat(cat)
        }
    }
    
    static private func destinationProfile(_ profile: ProfileDestination) -> some View {
        switch profile {
        case .profile(let userId):
            ProfileScreen(userId: userId)
        }
    }
    
    static private func destinationCat(_ cat: CatDestination) -> some View {
        switch cat {
        case .catInfo:
            CatFactInfosScreen()
        }
    }
    
}
