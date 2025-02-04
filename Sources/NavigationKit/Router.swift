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

}

public extension Router {
    func navigateToRoot() {
        navigationPath.removeAll()
    }

    func navigateTo(_ destination: Destination) {
        navigationPath.append(destination)
    }

    func presentSheet(_ destination: Destination, _ dismissAction: (() -> Void)? = nil) {
        presentedSheet = destination
        self.dismissAction = dismissAction
    }

    func presentFullScreen(_ destination: Destination, _ dismissAction: (() -> Void)? = nil) {
        presentedFullScreen = destination
        self.dismissAction = dismissAction
    }

    func presentModal(_ destination: Destination, _ dismissAction: (() -> Void)? = nil) {
        presentedModal = destination
        self.dismissAction = dismissAction
    }

    func presentModalCanFullScreen(_ destination: Destination, _ dismissAction: (() -> Void)? = nil) {
        presentedModalCanFullScreen = destination
        self.dismissAction = dismissAction
    }
    
    func presentModalFitContent(_ destination: Destination, _ dismissAction: (() -> Void)? = nil) {
        presentedModalFitContent = destination
        self.dismissAction = dismissAction
    }
    
    func presentModalAppleLike(_ destination: Destination, _ dismissAction: (() -> Void)? = nil) {
        presentedModalAppleLike = destination
        self.dismissAction = dismissAction
    }
}
