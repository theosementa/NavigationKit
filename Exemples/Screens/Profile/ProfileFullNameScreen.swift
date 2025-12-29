//
//  ProfileFullNameScreen.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import SwiftUI

struct ProfileFullNameScreen: View {
    
    let userId: String
    
    // MARK: Environments
    @Environment(PersonStore.self) private var personStore
    
    // MARK: Init
    public init(userId: String) {
        self.userId = userId
    }
    
    // MARK: Computed variables
    var person: PersonModel? {
        return personStore.findOneBy(id: userId)
    }
    
    // MARK: - View
    var body: some View {
        if let person {
            Text(person.fullname)
                .padding()
                .padding(.vertical)
        }
    }
    
}

// MARK: - Preview
#Preview {
    ProfileFullNameScreen(userId: "123")
}
