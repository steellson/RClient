//
//  ServerListSideBarViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import Foundation
import Kingfisher

final class ServerListSideBarViewModel: ObservableObject {
    
    @Published var servers: [ServerItem] = []
    @Published var selectedServer: ServerItem? = nil
    
    private let serverLogoPath = "/assets/favicon.svg"
//    private var imageCache = ImageCache(name: "ServerLogo")
    
    private let localStorageService: LocalStorageService
        
    init(
        localStorageService: LocalStorageService
    ) {
        self.localStorageService = localStorageService

    }
    
  
    func fetchServers() {
        servers = []
        
        let serverItems = localStorageService.getAllServerItems()
        guard !serverItems.isEmpty else {
            print("ServersSection: Fetched server items is empty!"); return
        }
        
        servers = serverItems
    }
    
}
