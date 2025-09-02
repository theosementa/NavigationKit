//
//  File.swift
//  NavigationKit
//
//  Created by Theo Sementa on 02/07/2025.
//

import SwiftUI

struct SheetPreviewableViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        Text("")
            .sheet(isPresented: .constant(true)) {
                content
            }
    }
}

public extension View {
    /// A view modifier that allows the view to be previewed as a sheet.
    ///
    /// This modifier is useful for SwiftUI previews, allowing you to see how the view looks when presented as a sheet.
    ///
    /// - Returns: A view that can be used in SwiftUI previews.
    func previewAsSheet() -> some View {
        self.modifier(SheetPreviewableViewModifier())
    }
}
