//
//  Route.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//

import Foundation

/// Enumeration of all type of navigation available
public enum Route {
    case push
    case sheet
    case fullScreenCover
    case modal
    case modalCanFullScreen
    case modalFitContent
    
    @available(iOS 17.0, *)
    case modalAppleLike
}

extension Route {
    var isPresentable: Bool {
        self != .push
    }
}
