//
//  ProfileDestination.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//

import Foundation
import NavigationModule

public enum ProfileDestination: DestinationItem {
    case list
    case details(userId: String)
    case fullName(userId: String)
}
