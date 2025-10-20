//
//  GenericNavigationButton.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//

import SwiftUI

/// A configurable navigation button that triggers navigation or presentation based on a route.
///
/// `GenericNavigationButton` permet d'encapsuler la logique de navigation (push, sheet, full screen, modal, etc.)
/// dans un simple `Button`, tout en s'intégrant à un `Router` fourni via `@EnvironmentObject`.
///
/// - Parameters:
///   - Destination: The type representing navigation destinations. Must conform to `AppDestinationProtocol`.
///   - Label: A SwiftUI view used as the button's label.
public struct GenericNavigationButton<Destination: AppDestinationProtocol, Label: View>: View {

    /// The type of navigation or presentation to perform.
    private let route: Route

    /// One or more destinations to navigate or present.
    private let destinations: [Destination]

    /// The content of the button.
    private let label: () -> Label

    /// An optional action to call when the view is dismissed.
    private let onDismiss: (() -> Void)?
    
    /// An optional action to call when the button is tapped, before navigation occurs.
    private let onNavigate: (() -> Void)?

    /// The router used to manage navigation, injected via the environment.
    @EnvironmentObject private var router: Router<Destination>

    /// The content and behavior of the button.
    ///
    /// When tapped, the button triggers a `push` or a presentation depending on the route.
    public var body: some View {
        Button {
            if let onNavigate { onNavigate() }
            
            switch route {
            case .push:
                router.push(destinations)
            case .sheet, .fullScreenCover, .modal, .modalCanFullScreen, .modalFitContent, .modalAppleLike:
                if let firstDestination = destinations.first {
                    router.present(route: route, firstDestination, onDismiss)
                }
            }
        } label: {
            if #available(iOS 18.0, *), destinations.count == 1, let firstDestination = destinations.first {
                label()
                    .matchedTransitionSource(id: firstDestination.id, in: router.namespace)
            } else {
                label()
            }
        }
    }
}

extension GenericNavigationButton {

    /// Creates a navigation button for a single destination and any route type.
    ///
    /// - Parameters:
    ///   - route: The type of route (e.g., `.push`, `.sheet`, `.modal`, etc.)
    ///   - destination: The destination to navigate or present.
    ///   - onDismiss: An optional action to call when the view is dismissed.
    ///   - onNavigate: An optional action to call when the button is tapped, before navigation occurs.
    ///   - label: A view builder that returns the button label.
    public init(
        route: Route,
        destination: Destination,
        onDismiss: (() -> Void)? = nil,
        onNavigate: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.route = route
        self.destinations = Array(arrayLiteral: destination)
        self.onDismiss = onDismiss
        self.onNavigate = onNavigate
        self.label = label
    }

    /// Creates a navigation button for pushing multiple destinations onto the navigation stack.
    ///
    /// - Important: This initializer must only be used with `.push` routes.
    ///
    /// - Parameters:
    ///   - route: Must be `.push`. Triggers navigation to a sequence of destinations.
    ///   - destinations: The destinations to push.
    ///   - onDismiss: Ignored for `.push` routes.
    ///   - onNavigate: An optional action to call when the button is tapped, before navigation occurs.
    ///   - label: A view builder that returns the button label.
    public init(
        route: Route,
        destinations: [Destination],
        onDismiss: (() -> Void)? = nil,
        onNavigate: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        precondition(route == .push, "This init can only be used with route == .push")
        self.route = route
        self.destinations = destinations
        self.onDismiss = onDismiss
        self.onNavigate = onNavigate
        self.label = label
    }
}
