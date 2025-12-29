//
//  PersonStore.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import Foundation

@Observable
final class PersonStore {
    static let shared = PersonStore()
    
    var persons: [PersonModel] = [.theo, .joris, .anthony]
    
}

extension PersonStore {
    
    func findOneBy(id: String) -> PersonModel? {
        return persons.first(where: { $0.id == id })
    }
    
}
