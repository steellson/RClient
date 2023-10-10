//
//  RClientContentView.swift
//  RClient
//
//  Created by Andrew Steellson on 10.10.2023.
//

import SwiftUI

struct RClientContentView: View {
    
    @ObservedObject var viewModel: RClientAppViewModel
    
    var body: some View {
        switch viewModel.globalState {
        case .login:
            LoginView(viewModel: ViewModelFactoryInstance.makeAuthorizationViewModel())
        case .root:
            NavigationSplitView {
                ServerListSideBarView(viewModel: ViewModelFactoryInstance.makeServerListSideBarViewModel())
                    .navigationSplitViewColumnWidth(86)
                
            } content: {
                ChannelSectionListView(viewModel: ViewModelFactoryInstance.makeChannelListSectionViewModel())
                    .frame(minWidth: 260, minHeight: 320)
                
            } detail: {
                ChatSectionView(viewModel: ViewModelFactoryInstance.makeChatSectionViewModel())
                    .frame(minWidth: 380, minHeight: 320)
                
            }
        case .settings:
            SettingsView(viewModel: ViewModelFactoryInstance.makeSettingsViewModel())
        case .none:
            EmptyView()
        }
    }
}

#Preview {
    RClientContentView(viewModel: ViewModelFactoryInstance.makeRClientViewModel())
}
