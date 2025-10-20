//
//  Router.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//

import Foundation
import SwiftUI

/// A generic router for managing navigation and presentation within a SwiftUI app.
///
/// `Router` tracks navigation paths as well as various presentation styles like sheets, modals, and full screen covers.
/// - Note: `AppDestination` must conform to `AppDestinationProtocol` and typically represents navigation targets in your app.
public class Router<AppDestination>: ObservableObject {

    /// The current stack of destinations in the navigation path.
    @Published public var navigationPath: [AppDestination] = []

    /// The currently presented sheet destination.
    @Published public var presentedSheet: AppDestination?

    /// The currently presented full screen cover destination.
    @Published public var presentedFullScreen: AppDestination?

    /// The currently presented modal destination.
    @Published public var presentedModal: AppDestination?

    /// The currently presented modal with a fit-content height.
    @Published public var presentedModalFitContent: AppDestination?

    /// The currently presented modal that can become full screen.
    @Published public var presentedModalCanFullScreen: AppDestination?
    
    @Published public var presentedModalAppleLike: AppDestination?

    /// The dismiss action to call when dismissing a presentation.
    @Published public var dismissAction: (() -> Void)?
    
    @Published public var namespace: Namespace.ID

    /// Creates a new instance of `Router`.
    public init() {
        let placeholder = Namespace().wrappedValue
        self.namespace = placeholder
    }
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
        navigationPath.append(destination)
    }

    /// Pushes multiple destinations onto the navigation stack.
    /// - Parameter destinations: The destinations to push.
    func push(_ destinations: [AppDestination]) {
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
        case .sheet:
            self.presentedSheet = destination
        case .fullScreenCover:
            self.presentedFullScreen = destination
        case .modal:
            self.presentedModal = destination
        case .modalCanFullScreen:
            self.presentedModalCanFullScreen = destination
        case .modalFitContent:
            self.presentedModalFitContent = destination
        case .modalAppleLike:
            self.presentedModalAppleLike = destination
        }

        self.dismissAction = dismissAction
    }

    /// Dismisses any currently presented destination.
    func dismiss() {
        if isPagePresented { pop() }
        if isSheetPresented { presentedSheet = nil }
        if isFullScreenPresented { presentedFullScreen = nil }
        if isModalPresented { presentedModal = nil }
        if isModalFitContentPresented { presentedModalFitContent = nil }
        if isModalCanFullScreenPresented { presentedModalCanFullScreen = nil }
        if isModalAppleLikePresented { presentedModalAppleLike = nil }
    }
}

public extension Router {
    /// Returns true if only the navigation path is used and no modal, sheet, or fullscreen presentation is active.
    var isPagePresented: Bool {
        return !isSheetPresented
        && !isFullScreenPresented
        && !isModalPresented
        && !isModalFitContentPresented
        && !isModalCanFullScreenPresented
        && !isModalAppleLikePresented
    }

    /// Returns true if a sheet is currently presented.
    var isSheetPresented: Bool {
        return presentedSheet != nil
    }

    /// Returns true if a full screen cover is currently presented.
    var isFullScreenPresented: Bool {
        return presentedFullScreen != nil
    }

    /// Returns true if a modal is currently presented.
    var isModalPresented: Bool {
        return presentedModal != nil
    }

    /// Returns true if a modal with fit-content height is currently presented.
    var isModalFitContentPresented: Bool {
        return presentedModalFitContent != nil
    }

    /// Returns true if a modal that can become fullscreen is currently presented.
    var isModalCanFullScreenPresented: Bool {
        return presentedModalCanFullScreen != nil
    }
    
    var isModalAppleLikePresented: Bool {
        return presentedModalAppleLike != nil
    }
}
