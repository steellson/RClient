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
    @Published var selectedChannel: Channel? = nil
        
    let serverListSideBarViewModel: ServerListSideBarViewModel
    let channelListSectionViewModel: ChannelSectionViewModel
    let chatSectionViewModel: ChatSectionViewModel
    
    private let navigationStateService: NavigationStateService
    private let localStorageService: LocalStorageService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        navigationStateService: NavigationStateService,
        localStorageService: LocalStorageService,
        serverListSideBarViewModel: ServerListSideBarViewModel,
        channelListSectionViewModel: ChannelSectionViewModel,
        chatSectionViewModel: ChatSectionViewModel
    ) {
        self.navigationStateService = navigationStateService
        self.localStorageService = localStorageService
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
                chatSectionViewModel.fetchMessages(withRoomID: selectedChannel.id)
            })
            .store(in: &cancellables)
        
        serverListSideBarViewModel.$selectedServer
            .removeDuplicates()
            .sink { [weak self] server in
                guard let url = server?.url else { return }
                self?.channelListSectionViewModel.fetchChannels(forServer: url)
            }
            .store(in: &cancellables)
    }
    
    func update() {
        guard let url = localStorageService.getAllServerItems().first?.url else { return }
        
        serverListSideBarViewModel.fetchServers()
        channelListSectionViewModel.fetchChannels(forServer: url)
    }
}
