//
//  ChatToolbarViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 05.10.2023.
//

import Foundation


final class ChatToolbarViewModel: ObservableObject {
    
    @Published var messageText: String = ""
    
    private let apiService: APIService
    private let navigationStateService: NavigationStateService
    private let localStorageService: LocalStorageService
    private let userService: UserService
    
    init(
        apiService: APIService,
        navigationStateService: NavigationStateService,
        localStorageService: LocalStorageService,
        userService: UserService
    ) {
        self.apiService = apiService
        self.navigationStateService = navigationStateService
        self.localStorageService = localStorageService
        self.userService = userService
    }
    
    
    func sendMessage() {
        guard let currentServerURL = navigationStateService.selectedServer?.url else {
            print("Couldnt find current server URL!"); return
        }
        guard let token = localStorageService.getAccessToken(forServer: currentServerURL) else {
            print("Couldnt find token!"); return
        }
        guard let currentUserID = userService.user?.id else {
            print("Couldnt find current user id!"); return
        }
        guard let currentRoomID = navigationStateService.selectedChannel?.id else {
            print("Couldnt find current channel!"); return
        }
        guard messageText != "" else { return }
    
        let message = MessageToSend(message: MessageToSend.Msg(rid: currentRoomID, msg: messageText))
        let messageCreditions = MessageCreditions(
            token: token,
            userID: currentUserID,
            roomId: currentRoomID
        )
        
        apiService.sendMessage(
            with: messageCreditions,
            message: message,
            serverURL: currentServerURL)
    }
}
