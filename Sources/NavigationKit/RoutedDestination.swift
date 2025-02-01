//
//  RoutedDestination.swift
//  NavigationKit
//
//  Created by Theo Sementa on 01/02/2025.
//

import SwiftUI

public protocol RoutedDestination {
    associatedtype Body: View
    @ViewBuilder @MainActor @preconcurrency func body(route: Route) -> Body
}
