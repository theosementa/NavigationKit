//
//  File.swift
//  NavigationKit
//
//  Created by Theo Sementa on 02/07/2025.
//

import SwiftUI

struct NavigationStackPreviewableViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack {
            content
        }
    }
}

public extension View {
    /// A view modifier that allows the view to be previewed within a `NavigationStack`.
    ///
    /// This modifier is useful for SwiftUI previews, allowing you to see how the view looks when embedded in a navigation stack.
    ///
    /// - Returns: A view that can be used in SwiftUI previews.
    func previewAsNavigationStack() -> some View {
        self.modifier(NavigationStackPreviewableViewModifier())
    }
}
