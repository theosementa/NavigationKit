//
//  NavigationDismissButton.swift
//  NavigationModule
//
//  Created by Theo Sementa on 25/06/2025.
//

import SwiftUI

/// A generic SwiftUI button that dismisses the current view when tapped.
///
/// `NavigationDismissButton` encapsule la logique de fermeture d'une vue (sheet, fullScreenCover, etc.)
/// en utilisant l'environnement SwiftUI `dismiss`, tout en permettant de personnaliser le label du bouton.
///
/// - Parameter Label: The view used as the button's content.
public struct NavigationDismissButton<Label: View>: View {
    
    /// A closure that returns the content of the button.
    private let label: () -> Label
    
    /// The environment-provided dismiss action from SwiftUI.
    @Environment(\.dismiss) private var dismiss
    
    /// Creates a new dismiss button with a custom label.
    ///
    /// - Parameter label: A view builder that provides the button label.
    public init(
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.label = label
    }
    
    /// The content and behavior of the button.
    ///
    /// When tapped, the button dismisses the current view using the SwiftUI `dismiss()` environment action.
    public var body: some View {
        Button(action: { dismiss() }, label: label)
    }
}
