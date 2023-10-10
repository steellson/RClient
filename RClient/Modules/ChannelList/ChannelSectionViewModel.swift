//
//  NavigationSectionViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation
import Combine

final class ChannelSectionViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    
    @Published var channels: [Channel] = []
    @Published var selectedChannel: Channel? = nil
    
    private let apiService: APIService
    private let localStorageService: LocalStorageService
    private let userService: UserService
    private let navigationStateService: NavigationStateService
            
    private var subscriptions = Set<AnyCancellable>()

    
    init(
        apiService: APIService,
        localStorageService: LocalStorageService,
        userService: UserService,
        navigationStateService: NavigationStateService
    ) {
        self.apiService = apiService
        self.localStorageService = localStorageService
        self.userService = userService
        self.navigationStateService = navigationStateService
        
        setupNavigationSelectionStateSubscription()
        setupDataFromSelectionSubsctiption()
    }
    
    private func fetchChannels(forServer url: String, userID: String) {
        guard let token = self.localStorageService.getAccessToken(forServer: url) else {
            print("Token not found!"); return
        }
        channels = []
        apiService.fetchChannels(forServer: url, currentUserId: userID, token: token) { [weak self] result in
            switch result {
            case .success(let channelResponse):
                self?.channels = channelResponse.channels
            case .failure(let error):
                print("ERROR: Couldnt fetch channels \(error)")
            }
        }
    }
}


//MARK: - Subscriptions

private extension ChannelSectionViewModel {

    func setupNavigationSelectionStateSubscription() {
        $selectedChannel
            .sink { [unowned self] channel in
                guard let selectedChannel = channel else { return }
                self.navigationStateService.selectedChannel = selectedChannel
            }
            .store(in: &subscriptions)
    }
    
    func setupDataFromSelectionSubsctiption() {
        Publishers.CombineLatest(
            navigationStateService.$selectedServer,
            userService.$user
        )
            .sink { server, user in
                guard let server = server, let user = user else { return }
                self.fetchChannels(forServer: server.url, userID: user.id)
            }
            .store(in: &subscriptions)
    }
}
