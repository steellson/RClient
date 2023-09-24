//
//  ServersListViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import Foundation
import Kingfisher

final class ServersListViewModel: ObservableObject {
    
    @Published var servers: [ServerItem] = []
    
    private let serverLogoPath = "/assets/favicon.svg"
    
    private let localStorageService: LocalStorageService
    
    init(
        localStorageService: LocalStorageService
    ) {
        self.localStorageService = localStorageService
        
        fetchServers()
    }
    
    private func fetchServers() {
        let creds = localStorageService.getAllServerCreds()
        guard !creds.isEmpty else {
            print("ServersSection: Fetched creds is empty!"); return
        }
        creds.forEach { cred in
            servers.append(
                ServerItem(
                    name: cred.nameOfServer ?? "",
                    image: KFImage(URL(string: "\(cred.url)\(serverLogoPath)"))
                )
            )
        }
    }
    
}
