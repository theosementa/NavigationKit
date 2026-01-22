//
//  Router.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//

import Foundation

/// A generic router for managing navigation and presentation within a SwiftUI app.
///
/// `Router` tracks navigation paths as well as various presentation styles like sheets, modals, and full screen covers.
/// - Note: `AppDestination` must conform to `AppDestinationProtocol` and typically represents navigation targets in your app.
@Observable
public class Router<AppDestination> {

    /// The current stack of destinations in the navigation path.
    public var navigationPath: [AppDestination] = []

    /// The currently presented sheet destination.
    public var presentedSheet: AppDestination?
    
    /// The currently presented route for the presented destination.
    public var selectedRoute: Route?

    /// The currently presented full screen cover destination.
    public var presentedFullScreen: AppDestination?

    /// The dismiss action to call when dismissing a presentation.
    public var dismissAction: (() -> Void)?

    /// Creates a new instance of `Router`.
    public init() {}
    
}

public extension Router {
    
    /// Removes all destinations and pops to the root of the navigation stack.
    func popToRoot() {
        navigationPath.removeAll()
    }

    /// Removes the last destination from the navigation stack.
    func pop() {
        navigationPath.removeLast()
    }

    /// Pushes a single destination onto the navigation stack.
    /// - Parameter destination: The destination to push.
    func push(_ destination: AppDestination) {
        selectedRoute = nil
        navigationPath.append(destination)
    }

    /// Pushes multiple destinations onto the navigation stack.
    /// - Parameter destinations: The destinations to push.
    func push(_ destinations: [AppDestination]) {
        selectedRoute = nil
        navigationPath.append(contentsOf: destinations)
    }
    
}

public extension Router {
    
    /// Presents a destination using the specified route type.
    ///
    /// - Parameters:
    ///   - route: The presentation route type (e.g., sheet, modal, fullScreenCover).
    ///   - destination: The destination to present.
    ///   - dismissAction: An optional action to perform when the presentation is dismissed.
    func present(route: Route, _ destination: AppDestination, _ dismissAction: (() -> Void)? = nil) {
        precondition(route != .push, "Push route is not supported in this presentation method")
        guard route.isPresentable else { return }

        switch route {
        case .push:
            break
        case .sheet(let style):
            self.selectedRoute = .sheet(style: style)
            self.presentedSheet = destination
        case .fullScreenCover:
            self.selectedRoute = .fullScreenCover
            self.presentedFullScreen = destination
        }

        self.dismissAction = dismissAction
    }

    /// Dismisses any currently presented destination.
    func dismiss() {
        if isPagePresented { pop() }
        if isSheetPresented { presentedSheet = nil }
        if isFullScreenPresented { presentedFullScreen = nil }
    }
    
}

public extension Router {
    
    /// Returns true if only the navigation path is used and no modal, sheet, or fullscreen presentation is active.
    var isPagePresented: Bool {
        return !isSheetPresented
        && !isFullScreenPresented
    }

    /// Returns true if a sheet is currently presented.
    var isSheetPresented: Bool {
        return presentedSheet != nil
    }

    /// Returns true if a full screen cover is currently presented.
    var isFullScreenPresented: Bool {
        return presentedFullScreen != nil
    }

}
