//
//  HomeViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
        
    private let navigationSectionViewModel: NavigationSectionViewModel
    private let chatSectionViewModel: ChatSectionViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        navigationSectionViewModel: NavigationSectionViewModel,
        chatSectionViewModel: ChatSectionViewModel
    ) {
        self.navigationSectionViewModel = navigationSectionViewModel
        self.chatSectionViewModel = chatSectionViewModel
        
        setChatSubscribe()
    }
    
    func setChatSubscribe() {
        navigationSectionViewModel.$selectedChat
            .removeDuplicates()
            .map { $0 }
            .assign(to: \.chat, on: chatSectionViewModel)
            .store(in: &cancellables)
    }
}
