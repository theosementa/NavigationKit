//
//  NavigationRegistry.swift
//  NavigationKit
//
//  Created by Theo Sementa on 21/01/2026.
//

import SwiftUI

public class NavigationRegistry {
    @MainActor public static let shared = NavigationRegistry()
    
    private var resolvers: [String: (Any) -> AnyView] = [:]

    private init() {}

    public func register<D: Hashable>(_ type: D.Type, resolver: @escaping (D) -> AnyView) {
        let key = String(reflecting: type)
        resolvers[key] = { destination in
            guard let typedDestination = destination as? D else {
                return AnyView(Text("Type error for \(key)"))
            }
            return resolver(typedDestination)
        }
    }

    public func resolve(_ destination: Any) -> AnyView {
        let base: Any = (destination as? AnyHashable)?.base ?? destination
        let key = String(reflecting: type(of: base))

        if let view = base as? AnyView { return view }

        if let resolver = resolvers[key] {
            return resolver(base)
        }
        
        if let recursive = base as? RecursiveDestination {
            let unwrappedValue = recursive.unwrapped
            if String(reflecting: type(of: unwrappedValue.base)) != key {
                return resolve(unwrappedValue)
            }
        }

        return AnyView(
            VStack {
                Text("Destination not found").bold()
                Text(key).font(.caption)
            }.foregroundColor(.red)
        )
    }
}
