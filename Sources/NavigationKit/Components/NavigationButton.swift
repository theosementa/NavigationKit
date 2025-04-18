//
//  NavigationButton.swift
//  NavigationKit
//
//  Created by Theo Sementa on 22/03/2025.
//

import SwiftUI

public struct NavigationButton<Destination: AppDestinationProtocol, Label: View>: View {
    private let route: Route
    private let destinations: [Destination]
    private let label: () -> Label
    private let onNavigate: (() -> Void)?
    private let onDismiss: (() -> Void)?
    
    @EnvironmentObject private var router: Router<Destination>
    
    public var body: some View {
        Button(action: {
            switch route {
            case .push:
                router.push(destinations)
            case .sheet, .fullScreenCover, .modal, .modalCanFullScreen, .modalFitContent, .modalAppleLike:
                if let firstDestination = destinations.first {
                    router.present(route: route, firstDestination, onDismiss)
                }
            }
            
            if let onNavigate { onNavigate() }
        }, label: label)
    }
}

extension NavigationButton {
    
    public init(
        route: Route,
        destination: Destination,
        onNavigate: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.route = route
        self.destinations = Array(arrayLiteral: destination)
        self.onNavigate = onNavigate
        self.onDismiss = onDismiss
        self.label = label
    }
    
    /// This init can only be used with route == .push
    public init(
        route: Route,
        destinations: [Destination],
        onNavigate: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        precondition(route == .push, "This init can only be used with route == .push")
        self.route = route
        self.destinations = destinations
        self.onNavigate = onNavigate
        self.onDismiss = onDismiss
        self.label = label
    }
    
}
