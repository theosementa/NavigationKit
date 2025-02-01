//
//  Route.swift
//  NavigationKit
//
//  Created by Theo Sementa on 01/02/2025.
//

import Foundation

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
