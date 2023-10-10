//
//  ServerListSideBarViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import Foundation
import Combine

final class ServerListSideBarViewModel: ObservableObject {
    
    @Published var servers: [ServerItem] = []
    @Published var selectedServer: ServerItem? = nil
    
    private let serverLogoPath = "/assets/favicon.svg"
    
    private let localStorageService: LocalStorageService
    private let navigationStateService: NavigationStateService
    
    private var subscriptions = Set<AnyCancellable>()
        
    init(
        localStorageService: LocalStorageService,
        navigationStateService: NavigationStateService
    ) {
        self.localStorageService = localStorageService
        self.navigationStateService = navigationStateService
        
        setupServerListSubscription()
        setupNavigationSelectionStateSubscription()
    }
    
  
    private func fetchServers() {
        servers = []
        
        let serverItems = localStorageService.getAllServerItems()
        guard !serverItems.isEmpty else {
            print("ServersSection: Fetched server items is empty!"); return
        }
        servers = serverItems
    }
    
}

//MARK: - Subscriptions

private extension ServerListSideBarViewModel {
    
    func setupServerListSubscription() {
        navigationStateService.$globalState
            .sink { [unowned self] state in
                if state == .root {
                    self.fetchServers()
                }
            }
            .store(in: &subscriptions)
    }
    
    func setupNavigationSelectionStateSubscription() {
        $selectedServer
            .sink { [unowned self] server in
                guard let server = server else { return }
                self.navigationStateService.selectedServer = server
            }
            .store(in: &subscriptions)
    }
}
