//
//  AppDestination.swift
//  NavigationModule
//
//  Created by Fabrice Ortega on 17/06/2025.
//

import SwiftUI
import NavigationModule

public enum AppDestination: AppDestinationProtocol {
    case profile(ProfileDestination)
    case random(RandomDestination)
}

extension AppDestination {
    
    @ViewBuilder
    static func content(for destination: AppDestination) -> some View {
        switch destination {
        case .profile(let profileDestination):
            destinationProfile(profileDestination)
        case .random(let randomDestination):
            destinationRandom(randomDestination)
        }
    }
    
    @ViewBuilder
    static private func destinationProfile(_ profile: ProfileDestination) -> some View {
        switch profile {
        case .list:
            ProfileListScreen()
        case .details(let userId):
            ProfileDetailsScreen(userId: userId)
        case .fullName(let userId):
            ProfileFullNameScreen(userId: userId)
        }
    }
    
    static private func destinationRandom(_ random: RandomDestination) -> some View {
        switch random {
        case .home:
            RandomNumberScreen()
        }
    }
    
}
