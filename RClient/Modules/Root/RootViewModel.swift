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
    
    let addServerViewModel: AddServerViewModel
    let settingsViewModel: SettingsViewModel
    
    private let navigationStateService: NavigationStateService
    private let localStorageService: LocalStorageService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        navigationStateService: NavigationStateService,
        localStorageService: LocalStorageService,
        serverListSideBarViewModel: ServerListSideBarViewModel,
        channelListSectionViewModel: ChannelSectionViewModel,
        chatSectionViewModel: ChatSectionViewModel,
        addServerViewModel: AddServerViewModel,
        settingsViewModel: SettingsViewModel
    ) {
        self.navigationStateService = navigationStateService
        self.localStorageService = localStorageService
        self.serverListSideBarViewModel = serverListSideBarViewModel
        self.channelListSectionViewModel = channelListSectionViewModel
        self.chatSectionViewModel = chatSectionViewModel
        self.addServerViewModel = addServerViewModel
        self.settingsViewModel = settingsViewModel
        
        // Subscriptions activate
        setupNavigationStateServiceSubscription()
        setupServerListSideBarSubscription()
        setupChannelListSectionSubscription()
    }
    
    func update() {
        guard let url = localStorageService.getAllServerItems().first?.url else { return }
        
        serverListSideBarViewModel.fetchServers()
        channelListSectionViewModel.fetchChannels(forServer: url)
    }
}

//MARK: - Subscriptions

private extension RootViewModel {
    
    func setupNavigationStateServiceSubscription() {
        navigationStateService.$globalState
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
    
    func setupServerListSideBarSubscription() {
        serverListSideBarViewModel.$selectedServer
            .removeDuplicates()
            .sink { [weak self] server in
                guard let url = server?.url else { return }
                self?.channelListSectionViewModel.fetchChannels(forServer: url)
            }
            .store(in: &cancellables)
        
//        serverListSideBarViewModel.$isJoinServerButtonPressed
//            .sink { [weak self] isPressed in
//                if isPressed {
//                    self?.navigationStateService.globalState = .joinWelcomeServer
//                } else {
//                    self?.navigationStateService.globalState = .root
//                }
//            }
//            .store(in: &cancellables)
//        
//        serverListSideBarViewModel.$isSettingsButtonPressed
//            .sink { [weak self] isPressed in
//                if isPressed {
//                    self?.navigationStateService.globalState = .settings
//                } else {
//                    self?.navigationStateService.globalState = .root
//                }
//            }
//            .store(in: &cancellables)
    }
    
    func setupChannelListSectionSubscription() {
        channelListSectionViewModel.$selectedChannel
            .sink(receiveValue: { [weak self] channel in
                guard let selectedChannel = channel else { return }
                self?.chatSectionViewModel.fetchMessages(withRoomID: selectedChannel.id)
            })
            .store(in: &cancellables)
    }
}
