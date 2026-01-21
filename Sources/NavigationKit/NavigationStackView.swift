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
    Flow: AppFlowProtocol,
    Destination: AppDestinationProtocol
>: View {

    /// The router managing the navigation path and presentation state.
    @ObservedObject private var router: Router<Destination>
    
    /// The central manager responsible for coordinating flows and registering routers.
    @ObservedObject private var routerManager: RouterManager<Flow, Destination>
    
    /// The unique identifier for the application flow represented by this stack.
    private let flow: Flow
    
    /// A Boolean value indicating whether this stack represents a persistent tab page.
    private let isTabPage: Bool

    /// The initial content view displayed at the root of the stack.
    private let initialContent: () -> InitialContent

    /// Resolve view for a given destination.
    private let registery: NavigationRegistry = .shared

    /// Creates a new instance of `NavigationStackView`.
    ///
    /// - Parameters:
    ///   - router: A `Router` instance that manages the navigation stack and presentation state.
    ///   - destinationContent: A closure that takes a `Destination` and returns a view.
    ///   - initialContent: A closure that returns the initial root view of the navigation stack.
    public init(
        router: Router<Destination>,
        routerManager: RouterManager<Flow, Destination>,
        flow: Flow,
        isTabPage: Bool = true,
        initialContent: @escaping () -> InitialContent
    ) {
        self.router = router
        self.routerManager = routerManager
        self.flow = flow
        self.isTabPage = isTabPage
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
                    registery.resolve(destination)
                }
                .sheet(item: $router.presentedSheet, onDismiss: router.dismissAction) { destination in
                    switch router.selectedRoute {
                    case .sheet(let style):
                        switch style {
                        case .medium:
                            registery.resolve(destination)
                                .presentationDetents([.medium])
                        case .large:
                            registery.resolve(destination)
                        case .canFullScreen:
                            registery.resolve(destination)
                                .presentationDetents([.medium, .large])
                        case .fitContent:
                            registery.resolve(destination)
                                .fittedPresentationDetent()
                        case .airpodsLike:
                            registery.resolve(destination)
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
                        }
                    default:
                        EmptyView()
                    }
                }
                .fullScreenCover(item: $router.presentedFullScreen, onDismiss: router.dismissAction) { destination in
                    registery.resolve(destination)
                }
        }
        .tag(flow)
        .environmentObject(router)
        .onAppear {
            routerManager.register(router: router, for: flow)
            routerManager.setCurrentFlow(flow)
        }
        .onDisappear {
            if isTabPage == false {
                routerManager.setPreviousFlow()
                routerManager.unregister(for: flow)
            }
        }
    }
}
