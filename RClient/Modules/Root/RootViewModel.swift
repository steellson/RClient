//
//  RootViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    
    @Published var searchText: String = ""
        
    private let navigationSectionViewModel: ChannelSectionViewModel
    private let chatSectionViewModel: ChatSectionViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        navigationSectionViewModel: ChannelSectionViewModel,
        chatSectionViewModel: ChatSectionViewModel
    ) {
        self.navigationSectionViewModel = navigationSectionViewModel
        self.chatSectionViewModel = chatSectionViewModel
        
        setChatSubscribe()
    }
    
    func setChatSubscribe() {
        cancellables = []
        navigationSectionViewModel.$selectedChat
            .removeDuplicates()
            .map { $0 }
            .assign(to: \.chat, on: chatSectionViewModel)
            .store(in: &cancellables)
    }
}
