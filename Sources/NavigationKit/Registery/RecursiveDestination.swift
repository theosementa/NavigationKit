//
//  RecursiveDestination.swift
//  NavigationKit
//
//  Created by Theo Sementa on 21/01/2026.
//

import Foundation

public protocol RecursiveDestination {
    var unwrapped: AnyHashable { get }
}
