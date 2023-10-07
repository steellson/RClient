//
//  RootView.swift
//  RClient
//
//  Created by Andrew Steellson on 26.09.2023.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var viewModel: RootViewModel
        
    var body: some View {
        
        switch viewModel.state {
        case .joinWelcomeServer:
            JoinServerView(viewModel: ViewModelFactoryInstance.makeJoinServerViewModel())
        case .login:
            LoginView(viewModel:             ViewModelFactoryInstance.makeAuthorizationViewModel())
        case .root:
            NavigationSplitView {
                ServerListSideBarView(viewModel: viewModel.serverListSideBarViewModel)
                    .navigationSplitViewColumnWidth(86)
                
            } content: {
                ChannelSectionListView(viewModel: viewModel.channelListSectionViewModel)
                    .frame(minWidth: 260, minHeight: 320)
                
            } detail: {
                ChatSectionView(viewModel: viewModel.chatSectionViewModel)
                    .frame(minWidth: 380, minHeight: 320)
                
            }
            .onAppear {
                viewModel.update()
            }
        case .settings:
            SettingsView(viewModel: viewModel.settingsViewModel)
        case .none:
            EmptyView()
        }
    }
}

#Preview {
    RootView(viewModel: ViewModelFactoryInstance.makeRootViewModel())
}
