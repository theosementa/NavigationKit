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
        guard route.isPresentable else {
            print("Push route is not supported in this presentation method")
            return
        }
        
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
    
    var isPagePresented: Bool {
        return !isSheetPresented
        && !isFullScreenPresented
        && !isModalPresented
        && !isModalFitContentPresented
        && !isModalCanFullScreenPresented
        && !isModalAppleLikePresented
    }
    
    var isSheetPresented: Bool {
        return presentedSheet != nil
    }
    
    var isFullScreenPresented: Bool {
        return presentedFullScreen != nil
    }
    
    var isModalPresented: Bool {
        return presentedModal != nil
    }
    
    var isModalFitContentPresented: Bool {
        return presentedModalFitContent != nil
    }
    
    var isModalCanFullScreenPresented: Bool {
        return presentedModalCanFullScreen != nil
    }
    
    var isModalAppleLikePresented: Bool {
        return presentedModalAppleLike != nil
    }
    
}
