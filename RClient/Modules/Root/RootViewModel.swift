//
//  RootViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    
    let serverListSideBarViewModel: ServerListSideBarViewModel
    let channelListSectionViewModel: ChannelSectionViewModel
    let chatSectionViewModel: ChatSectionViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        serverListSideBarViewModel: ServerListSideBarViewModel,
        channelListSectionViewModel: ChannelSectionViewModel,
        chatSectionViewModel: ChatSectionViewModel
    ) {
        self.serverListSideBarViewModel = serverListSideBarViewModel
        self.channelListSectionViewModel = channelListSectionViewModel
        self.chatSectionViewModel = chatSectionViewModel
        
        setChatSubscribe()
    }
    
    func setChatSubscribe() {
        cancellables = []
        channelListSectionViewModel.$selectedChannel
            .removeDuplicates()
            .map { $0 }
            .assign(to: \.chat, on: chatSectionViewModel)
            .store(in: &cancellables)
    }
}
