//
//  NavigationStackView.swift
//  NavigationModule
//
//  Created by Theo Sementa on 25/06/2025.
//

import SwiftUI

/// A generic SwiftUI view that manages navigation and modal presentation using a `Router`.
///
/// `NavigationStackView` centralise la navigation dans une application SwiftUI via un objet `Router`,
/// tout en supportant les différentes présentations : `sheet`, `fullScreenCover`, `modal`, etc.
///
/// - Parameters:
///   - InitialContent: The root view displayed at the base of the navigation stack.
///   - Destination: The enum or type conforming to `AppDestinationProtocol` that identifies navigation destinations.
///   - DestinationContent: The type of view to render for a given `Destination`.
public struct NavigationStackView<
    InitialContent: View,
    Destination: AppDestinationProtocol,
    DestinationContent: View
>: View {

    /// The router managing the navigation path and presentation state.
    @ObservedObject private var router: Router<Destination>

    /// The initial content view displayed at the root of the stack.
    private let initialContent: () -> InitialContent

    /// A closure that generates a view for a given destination.
    private let destinationContent: (_ destination: Destination) -> DestinationContent

    /// Creates a new instance of `NavigationStackView`.
    ///
    /// - Parameters:
    ///   - router: A `Router` instance that manages the navigation stack and presentation state.
    ///   - destinationContent: A closure that takes a `Destination` and returns a view.
    ///   - initialContent: A closure that returns the initial root view of the navigation stack.
    public init(
        router: Router<Destination>,
        destinationContent: @escaping (_ destination: Destination) -> DestinationContent,
        initialContent: @escaping () -> InitialContent
    ) {
        self.router = router
        self.destinationContent = destinationContent
        self.initialContent = initialContent
    }

    /// The content and behavior of the view.
    ///
    /// Includes:
    /// - Navigation via `NavigationStack`
    /// - Injection of the `Router` as an `EnvironmentObject`
    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            initialContent()
                .navigationDestination(for: Destination.self) { destination in
                    if #available(iOS 18.0, *) {
                        destinationContent(destination)
                            .navigationTransition(.zoom(sourceID: destination.id, in: router.namespace))
                    } else {
                        destinationContent(destination)
                    }
                }
                .sheet(item: $router.presentedSheet, onDismiss: router.dismissAction) { destination in
                    destinationContent(destination)
                }
                .sheet(item: $router.presentedModal, onDismiss: router.dismissAction) { destination in
                    destinationContent(destination)
                        .presentationDetents([.medium])
                }
                .sheet(item: $router.presentedModalCanFullScreen, onDismiss: router.dismissAction) { destination in
                    destinationContent(destination)
                        .presentationDetents([.medium, .large])
                }
                .fullScreenCover(item: $router.presentedFullScreen, onDismiss: router.dismissAction) { destination in
                    destinationContent(destination)
                }
                .sheet(item: $router.presentedModalFitContent, onDismiss: router.dismissAction) { destination in
                    destinationContent(destination)
                        .fittedPresentationDetent()
                }
                .sheet(item: $router.presentedModalAppleLike, onDismiss: router.dismissAction) { destination in
                    if #available(iOS 17.0, *) {
                        destinationContent(destination)
                            .padding()
                            .fittedPresentationDetent()
                            .presentationBackground {
                                UnevenRoundedRectangle(
                                    topLeadingRadius: UIScreen.main.displayCornerRadius / 1.5,
                                    bottomLeadingRadius: UIScreen.main.displayCornerRadius,
                                    bottomTrailingRadius: UIScreen.main.displayCornerRadius,
                                    topTrailingRadius: UIScreen.main.displayCornerRadius / 1.5
                                )
                                .fill(Color(uiColor: .systemBackground))
                                .padding(3)
                            }
                    } else {
                        // Fallback on earlier versions
                    }
                }
        }
        .environmentObject(router)
    }
}
