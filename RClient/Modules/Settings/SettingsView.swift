//
//  SettingsView.swift
//  RClient
//
//  Created by Andrew Steellson on 03.10.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack() {
            Spacer()
            
            Text("Settings will be soon")
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: 300, height: 100)
            
            Text("🚀🚀🚀")
                .font(.title)

            Spacer()
        }
    }
}

#Preview {
    SettingsView(viewModel: ViewModelFactoryInstance.makeSettingsViewModel())
}
