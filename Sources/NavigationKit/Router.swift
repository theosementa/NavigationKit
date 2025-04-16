//
//  Router.swift
//  NavigationKit
//
//  Created by Theo Sementa on 01/02/2025.
//

import SwiftUI

open class Router<Destination>: ObservableObject {
    @Published var navigationPath: [Destination] = []
    @Published var presentedSheet: Destination?
    @Published var presentedFullScreen: Destination?
    @Published var presentedModal: Destination?
    @Published var presentedModalFitContent: Destination?
    @Published var presentedModalCanFullScreen: Destination?
    @Published var presentedModalAppleLike: Destination?
    
    @Published var dismissAction: (() -> Void)?
    
    public init() {}
}

public extension Router {
    
    func popToRoot() {
        navigationPath.removeAll()
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func push(_ destination: Destination) {
        navigationPath.append(destination)
    }
    
    func push(_ destinations: [Destination]) {
        navigationPath.append(contentsOf: destinations)
    }

}

public extension Router {
    
    func present(route: Route, _ destination: Destination, _ dismissAction: (() -> Void)? = nil) {
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
    
}
