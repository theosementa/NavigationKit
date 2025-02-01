//
//  RoutedNavigationStack.swift
//  NavigationKit
//
//  Created by Theo Sementa on 01/02/2025.
//


import Foundation
import SwiftUI

public struct RoutedNavigationStack<Content: View, Destination: RoutedDestination & Identifiable & Hashable>: View {
    @ObservedObject var router: Router<Destination>
    private let content: () -> Content

    public init(router: Router<Destination>, content: @escaping () -> Content) {
        self.router = router
        self.content = content
    }

    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            content()
                .navigationDestination(for: Destination.self) { destination in
                    destination
                        .body(route: .push)
                }
                .sheet(item: $router.presentedSheet, onDismiss: router.dismissAction) { destination in
                    destination
                        .body(route: .sheet)
                }
                .sheet(item: $router.presentedModal, onDismiss: router.dismissAction) { destination in
                    destination
                        .body(route: .sheet)
                        .presentationDetents([.medium])
                }
                .sheet(item: $router.presentedModalCanFullScreen, onDismiss: router.dismissAction) { destination in
                    destination
                        .body(route: .sheet)
                        .presentationDetents([.medium, .large])
                }
                .fullScreenCover(item: $router.presentedFullScreen, onDismiss: router.dismissAction) { destination in
                    destination
                        .body(route: .fullScreenCover)
                }
                .sheet(item: $router.presentedModalFitContent, onDismiss: router.dismissAction) { destination in
                    destination
                        .body(route: .modalFitContent)
                        .fittedPresentationDetent()
                }
                .sheet(item: $router.presentedModalAppleLike, onDismiss: router.dismissAction) { destination in
                    if #available(iOS 17.0, *) {
                        destination
                            .body(route: .modalAppleLike)
                            .fittedPresentationDetent()
                            .presentationBackground {
                                UnevenRoundedRectangle(
                                    topLeadingRadius: UIScreen.main.displayCornerRadius / 1.5,
                                    bottomLeadingRadius: UIScreen.main.displayCornerRadius,
                                    bottomTrailingRadius: UIScreen.main.displayCornerRadius,
                                    topTrailingRadius: UIScreen.main.displayCornerRadius / 1.5
                                )
                                .fill(Color.white)
                                .padding(3)
                            }
                    } else {
                        // Fallback on earlier versions
                    }
                }
        }
    }
}
