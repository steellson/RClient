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
        let creds = localStorageService.getAllServerCreds()
        guard !creds.isEmpty else {
            print("NavigationSection: Fetched creds is empty!"); return
        }
//        creds.forEach { cred in
//            channels.append(
//                Channel(
//                    id: <#T##String#>,
//                    name: <#T##String#>,
//                    iconName: <#T##String?#>
//                )
//            )
//        }
    }
}
