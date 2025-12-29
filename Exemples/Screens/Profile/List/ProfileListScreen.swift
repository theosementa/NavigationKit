//
//  ProfileListScreen.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import SwiftUI

struct ProfileListScreen: View {
    
    // MARK: Environments
    @Environment(PersonStore.self) private var personStore
    
    // MARK: States
    @State private var viewModel: ViewModel = .init()
    
    // MARK: - View
    var body: some View {
        List(personStore.persons, id: \.self) { person in
            Button {
                viewModel.onTapDetail(userId: person.id)
            } label: {
                Text(person.fullname)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ProfileListScreen()
}
