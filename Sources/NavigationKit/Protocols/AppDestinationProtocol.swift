//
//  AppDestinationProtocol.swift
//  NavigationModule
//
//  Created by Theo Sementa on 24/06/2025.
//

import Foundation

/// A protocol that represents a navigable destination in a SwiftUI application.
///
/// Conform types (typically enums) to `AppDestinationProtocol` to describe all possible navigation
/// targets in a modular and type-safe way. This is used by the `Router` and `NavigationStackView`
/// to handle navigation paths and modal presentations.
///
/// Conforming to `AppDestinationProtocol` requires `Identifiable` and `Hashable`,
/// allowing use with SwiftUI navigation APIs.
public protocol AppDestinationProtocol: Identifiable, Hashable { }

/// Default implementation of `Identifiable` for `AppDestinationProtocol` using the `hashValue` as `id`.
///
/// This allows enums or structs conforming to `AppDestinationProtocol` to automatically be used
/// in `ForEach`, `.sheet(item:)`, and other SwiftUI constructs that rely on identity.
extension AppDestinationProtocol {
    /// A default `id` based on the `hashValue`.
    ///
    /// - Note: Override this if you need stable identifiers across sessions.
    public var id: Int { hashValue }
}
