//
//  FittedPresentationDetentModifier.swift
//  NavigationKit
//
//  Created by Theo Sementa on 01/02/2025.
//


import SwiftUI

struct FittedPresentationDetentModifier: ViewModifier {
    @State private var contentSize: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .onGeometryChange(for: CGSize.self, of: \.size) { newSize in
                guard newSize != .zero else { return }
                contentSize = newSize
            }
            .presentationDetents([.height(contentSize.height)])
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension View {
    func fittedPresentationDetent() -> some View {
        modifier(FittedPresentationDetentModifier())
    }
}
