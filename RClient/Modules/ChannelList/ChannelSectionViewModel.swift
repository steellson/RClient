//
//  NavigationSectionViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation
import Moya

final class ChannelSectionViewModel: ObservableObject {
    
    @Published var channels: [Channel] = []
    @Published var selectedChannel: Channel? = nil
    
    @Published var searchText: String = ""
    
    private let userService: UserService
    private let localStorageService: LocalStorageService
    private let moyaProvider: MoyaProvider<RocketChatAPI>
            
    init(
        userService: UserService,
        localStorageService: LocalStorageService,
        moyaProvider: MoyaProvider<RocketChatAPI>
    ) {
        self.moyaProvider = moyaProvider
        self.localStorageService = localStorageService
        self.userService = userService

    }
    
    func fetchChannels() {
        guard let currentUserId = localStorageService.getUserInfo().first?.id else {
            print("CurrentUserID cannot be found"); return
        }
        guard let currentServerURL = self.localStorageService.getAllServerCreds().first?.url else {
            print("CurrentServerURL is not found"); return
        }
        guard let token = self.localStorageService.getAccessToken(forServer: currentServerURL) else {
            print("Token not found!"); return
        }
        
        channels = []
        
        moyaProvider.request(.getJoinedChannelsList(token: token, userID: currentUserId), completion: { [weak self] result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let channelList = try JSONDecoder().decode(ChannelsResponse.self, from: response.data)
                        guard !channelList.channels.isEmpty else {
                            print("NavigationSection: Fetched channels is empty!"); return
                        }
                        self?.channels = channelList.channels
                        
                    } catch let error {
                        print("Cant decode channels: \(error)")
                    }
                    
                } else {
                    print("Fetching user status code: \(response.statusCode)")
                }
                
            case .failure(let error):
                print("Fetching user error: \(error.localizedDescription)")
            }
        })
    }
}
