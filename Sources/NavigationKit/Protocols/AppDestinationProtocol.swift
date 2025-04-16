//
//  AppDestination.swift
//  NavigationKit
//
//  Created by Theo Sementa on 01/02/2025.
//

import SwiftUI

public protocol AppDestinationProtocol: Identifiable, Hashable {
    associatedtype Body: View
    @ViewBuilder @MainActor @preconcurrency func body(route: Route) -> Body
}
