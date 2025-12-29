//
//  NavigationButtonView.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//
//  Wrapper Example

import SwiftUI
import NavigationKit

public struct NavigationButtonView<Label: View>: View {

    // MARK: Dependencies
    let route: Route
    let destination: AppDestination
    let label: () -> Label

    // MARK: Init
    public init(
        route: Route,
        destination: AppDestination,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.route = route
        self.destination = destination
        self.label = label
    }

    // MARK: - View
    public var body: some View {
        GenericNavigationButton(
            route: route,
            destination: destination,
            label: { label() }
        )
    }
}
