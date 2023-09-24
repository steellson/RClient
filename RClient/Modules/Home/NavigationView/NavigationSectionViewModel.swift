//
//  NavigationSectionViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation

final class NavigationSectionViewModel: ObservableObject {
    
    @Published var channels: [ChannelItem] = []
    
    private let localStorageService: LocalStorageService
    
    init(
        localStorageService: LocalStorageService
    ) {
        self.localStorageService = localStorageService
        
        fetchChannels()
    }
    
    private func fetchChannels() {
        let userInfo = localStorageService.getUserInfo()
        guard !userInfo.isEmpty else {
            print("NavigationSection: Fetched creds is empty!"); return
        }
        userInfo.forEach { user in
            channels.append(
                ChannelItem(
                    id: "",
                    name: "",
                    iconName: ""
                )
            )
        }
    }
}
