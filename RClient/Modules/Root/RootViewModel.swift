//
//  RootViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    
    @Published var state: GlobalState? = nil
    
    @Published var selectedServer: ServerItem? = nil
    @Published var selectedChannel: ChannelItem? = nil
        
    let serverListSideBarViewModel: ServerListSideBarViewModel
    let channelListSectionViewModel: ChannelSectionViewModel
    let chatSectionViewModel: ChatSectionViewModel
    
    private let navigationStateService: NavigationStateService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        navigationStateService: NavigationStateService,
        serverListSideBarViewModel: ServerListSideBarViewModel,
        channelListSectionViewModel: ChannelSectionViewModel,
        chatSectionViewModel: ChatSectionViewModel
    ) {
        self.navigationStateService = navigationStateService
        self.serverListSideBarViewModel = serverListSideBarViewModel
        self.channelListSectionViewModel = channelListSectionViewModel
        self.chatSectionViewModel = chatSectionViewModel
        
        navigationStateService.$globalState
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
        
        serverListSideBarViewModel.$selectedServer
            .assign(to: \.selectedServer, on: self)
            .store(in: &cancellables)
        
        channelListSectionViewModel.$selectedChannel
            .sink(receiveValue: { channel in
                guard let selectedChannel = channel else { return }
                print(channel)
                chatSectionViewModel.fetchMessages(withRoomID: selectedChannel.id)
            })
            .store(in: &cancellables)
        
    }
    
    func update() {
        serverListSideBarViewModel.fetchServers()
        channelListSectionViewModel.fetchChannels()
    }
}
