//
//  RouterManager.swift
//  NavigationKit
//
//  Created by Theo Sementa on 29/12/2025.
//

import Foundation

/// A central object responsible for managing the application's global navigation state and coordinating multiple routers.
///
/// `RouterManager` acts as the source of truth for the currently active `Flow` (e.g., a specific Tab or app section)
/// and maintains a registry of `Router` instances associated with each flow.
///
/// Usage implies injecting this object into the environment or passing it to the root view (like a `TabView`)
/// to control switching between major application sections.
open class RouterManager<Flow: AppFlowProtocol, Destination: AppDestinationProtocol>: ObservableObject {
    
    /// The currently active application flow.
    @Published public var selectedFlow: Flow
    
    /// The previously active flow, if any.
    @Published public var previousFlow: Flow?
    
    /// A dictionary storing the active router instance for each registered flow.
    @Published private var routers: [Flow: Router<Destination>] = [:]
    
    public init(
        selectedFlow: Flow,
        previousFlow: Flow? = nil,
        routers: [Flow : Router<Destination>] = [:]
    ) {
        self.selectedFlow = selectedFlow
        self.previousFlow = previousFlow
        self.routers = routers
    }
    
}

// MARK: - Computed variables
extension RouterManager {
    
    /// The current router for the current flow.
    public var currentRouter: Router<Destination>? {
        return getRouter(for: selectedFlow)
    }
    
}

// MARK: - Public functions
extension RouterManager {
    
    /// Retrieves the registered router for a specific flow.
    public func getRouter(for tab: Flow) -> Router<Destination>? {
        return routers[tab]
    }
    
    /// Navigate to a specific flow and execute an action 
    @MainActor
    public func navigateToFlow(_ flow: Flow, then: @escaping () -> Void) {
        self.selectedFlow = flow
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            then()
        }
    }
    
}

// MARK: - Private functions
extension RouterManager {
    
    /// Registers a router for a specific flow.
    internal func register(router: Router<Destination>, for flow: Flow) {
        guard routers[flow] == nil else { return }
        return routers[flow] = router
    }
    
    /// Unregisters the router associated with a specific flow.
    internal func unregister(for flow: Flow) {
        return routers[flow] = nil
    }
    
    /// Updates the current flow and archives the previous state.
    internal func setCurrentFlow(_ flow: Flow) {
        previousFlow = self.selectedFlow
        self.selectedFlow = flow
    }
    
    /// Reverts the active flow to the previously stored flow.
    ///
    /// This is particularly useful for handling the dismissal of non-persistent flows (e.g., a flow presented
    /// entirely within a full-screen cover that sits "above" the main `TabView`).
    internal func setPreviousFlow() {
        guard let previousFlow else { return }
        self.selectedFlow = previousFlow
    }
    
}
