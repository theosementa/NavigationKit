//
//  PersonModel.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import Foundation

struct PersonModel: Identifiable, Hashable {
    let id: String
    let fullname: String
}

extension PersonModel {
    
    static let theo: PersonModel = .init(
        id: UUID().uuidString,
        fullname: "Théo Sementa"
    )
    
    static let joris: PersonModel = .init(
        id: UUID().uuidString,
        fullname: "Joris Thiery"
    )
    
    static let anthony: PersonModel = .init(
        id: UUID().uuidString,
        fullname: "Anthony Chollet"
    )
    
}
