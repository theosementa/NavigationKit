//
//  ProfileDetailsScreen.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import SwiftUI
import NavigationModule

struct ProfileDetailsScreen: View {
    
    // MARK: Environments
    @EnvironmentObject private var appRouterManager: AppRouterManager
    @Environment(\.dismiss) private var dismiss
    
    // MARK: States
    @StateObject private var profileRouter: Router<AppDestination> = .init()
    @State private var viewModel: ViewModel
    
    // MARK: Init
    public init(userId: String) {
        self._viewModel = State(wrappedValue: .init(userId: userId))
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            FlowBannerView(flow: appRouterManager.selectedFlow)
            
            NavigationStackView(
                router: profileRouter,
                routerManager: appRouterManager,
                flow: .profile,
                isTabPage: false,
                destinationContent: { AppDestination.content(for: $0) }
            ) {
                VStack {
                    Button { dismiss() } label: {
                        Text("Dismiss")
                    }
                    
                    Text("Hello user : \(viewModel.userId)")
                    
                    Button {
                        viewModel.onTapPushFullName()
                    } label: {
                        Text("Go to full name")
                    }
                    
                    Button {
                        viewModel.onTapBottomSheetFullName()
                    } label: {
                        Text("Go to bottom sheet")
                    }

                    Button {
                        viewModel.onTapFitSheetFullName()
                    } label: {
                        Text("Go to fit sheet")
                    }
                }
            }
        }
    }
    
}

// MARK: - Preview
#Preview {
    ProfileDetailsScreen(userId: "123")
}
