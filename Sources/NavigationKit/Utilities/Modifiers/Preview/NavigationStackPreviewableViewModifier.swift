//
//  File.swift
//  NavigationKit
//
//  Created by Theo Sementa on 02/07/2025.
//

import Foundation
import SwiftUI

/// A view modifier that wraps content in a `NavigationStackView` for use in SwiftUI previews.
///
/// This is intended for use with preview providers, enabling navigation context and environment injection
/// for components relying on a `Router`.
///
/// - Note: The destination content is set to `EmptyView()` in previews.
struct NavigationStackPreview<T: AppDestinationProtocol>: ViewModifier {
    
    /// A router instance used for previewing.
    let previewRouter: Router<T>
    
    /// Wraps the provided content in a `NavigationStackView` with a dummy `destinationContent`.
    ///
    /// - Parameter content: The content view to embed in the navigation context.
    /// - Returns: A `NavigationStackView` embedding the content.
    func body(content: Content) -> some View {
        NavigationStackView(
            router: previewRouter,
            destinationContent: { _ in EmptyView() }
        ) {
            content
        }
        .environmentObject(previewRouter)
    }
}

extension View {
    /// Embeds the current view inside a `NavigationStackView` for SwiftUI previews.
    ///
    /// This allows views that depend on a `Router<T>` to be previewed properly by injecting a navigation context.
    ///
    /// - Parameter enum: The enum type representing navigation destinations (must conform to `AppDestinationProtocol`).
    /// - Returns: A view wrapped with a `NavigationStackView` and an injected `Router`.
    ///
    /// ### Example
    /// ```swift
    /// struct MyView_Previews: PreviewProvider {
    ///     static var previews: some View {
    ///         MyView()
    ///             .previewableNavigation(enum: AppDestination.self)
    ///     }
    /// }
    /// ```
    public func previewableNavigation<T: AppDestinationProtocol>(enum: T.Type) -> some View {
        let router = Router<T>()
        return modifier(NavigationStackPreview(previewRouter: router))
    }
}
