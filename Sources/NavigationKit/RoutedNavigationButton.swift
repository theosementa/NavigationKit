//
//  RoutedNavigationButton.swift
//  NavigationKit
//
//  Created by Theo Sementa on 01/02/2025.
//

import SwiftUI

public struct RoutedNavigationButton<Label: View>: View {
    private let action: () -> Void
    private let label: () -> Label

    private init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(action: action, label: label)
    }
}

// MARK: - Push

public extension RoutedNavigationButton {
    init(
        push: @escaping () -> Void,
        action: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: {
            action?()
            push()
        }, label: label)
    }

    init(
        push: @autoclosure @escaping () -> Void,
        action: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: {
            action?()
            push()
        }, label: label)
    }

    init<T>(
        push: @escaping (T) -> Void,
        value: T,
        action: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: {
            action?()
            push(value)
        }, label: label)
    }

    init<T>(
        push: @escaping (T?) -> Void,
        value: T?,
        action: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: {
            action?()
            push(value)
        }, label: label)
    }
}

// MARK: - Present

public extension RoutedNavigationButton {
    init<T>(
        present: @escaping (T, (() -> Void)?) -> Void,
        value: T,
        action: (() -> Void)? = nil,
        dismissAction: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: {
            action?()
            present(value, dismissAction)
        }, label: label)
    }

    init<T>(
        present: @escaping (T?, (() -> Void)?) -> Void,
        value: T?,
        action: (() -> Void)? = nil,
        dismissAction: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: {
            action?()
            present(value, dismissAction)
        }, label: label)
    }

    init(
        present: @autoclosure @escaping () -> Void,
        action: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(action: {
            action?()
            present()
        }, label: label)
    }
}
