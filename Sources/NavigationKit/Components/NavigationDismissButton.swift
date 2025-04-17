//
//  NavigationDismissButton.swift
//  NavigationKit
//
//  Created by Theo Sementa on 17/04/2025.
//

import SwiftUI

public struct NavigationDismissButton<Label: View>: View {
    private let label: () -> Label
    
    public init(
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.label = label
    }
    
    @Environment(\.dismiss) private var dismiss
    
    public var body: some View {
        Button(action: { dismiss() }, label: label)
    }
}
