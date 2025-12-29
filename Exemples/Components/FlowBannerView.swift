//
//  FlowBannerView.swift
//  POC_NavaigtionModuleProject
//
//  Created by Theo Sementa on 18/12/2025.
//

import SwiftUI

struct FlowBannerView: View {
    
    let flow: AppFlow
    
    var body: some View {
        Text("Current flow : \(flow)")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
    }
}

#Preview {
    FlowBannerView(flow: .random)
}
