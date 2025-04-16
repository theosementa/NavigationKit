//
//  NavigationButton.swift
//  NavigationKit
//
//  Created by Theo Sementa on 22/03/2025.
//

import SwiftUI

public struct NavigationButton<Destination: AppDestinationProtocol, Label: View>: View {
    private let route: Route
    private let destination: Destination
    private let label: () -> Label
    private let dismissAction: (() -> Void)?
    
    @EnvironmentObject private var router: Router<Destination>

    public init(
        route: Route,
        destination: Destination,
        dismissAction: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.route = route
        self.destination = destination
        self.dismissAction = dismissAction
        self.label = label
    }
    
    public var body: some View {
        Button(action: {
            switch route {
            case .push:
                router.push(destination)
            case .sheet, .fullScreenCover, .modal, .modalCanFullScreen, .modalFitContent, .modalAppleLike:
                router.present(route: route, destination, dismissAction)
            }
        }, label: label)
    }
}
