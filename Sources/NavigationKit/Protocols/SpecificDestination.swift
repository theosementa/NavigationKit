//
//  SpecificDestination.swift
//  NavigationKit
//
//  Created by Theo Sementa on 16/04/2025.
//

import SwiftUI

public protocol SpecificDestination: Identifiable, Hashable {
    associatedtype Body: View
    @ViewBuilder @MainActor @preconcurrency func renderBody(route: Route) -> Body
}
