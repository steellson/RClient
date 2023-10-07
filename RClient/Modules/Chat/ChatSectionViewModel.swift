//
//  ChatSectionViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation
import Moya

final class ChatSectionViewModel: ObservableObject {
            
    @Published var messages: [Message] = []
    
    private let localStorageService: LocalStorageService
    private let moyaProvider: MoyaProvider<RocketChatAPI>
    private let userService: UserService
    
    init(
        localStorageService: LocalStorageService,
        moyaProvider: MoyaProvider<RocketChatAPI>,
        userService: UserService
    ) {
        self.localStorageService = localStorageService
        self.moyaProvider = moyaProvider
        self.userService = userService
        
    }

    func fetchMessages(withRoomID roomId: String) {
        guard let currentUserId = localStorageService.getUserInfo().first?.id else {
            print("CurrentUserID cannot be found"); return
        }
        guard let currentServerURL = self.localStorageService.getAllServerItems().first?.url else {
            print("CurrentServerURL is not found"); return
        }
        guard let token = self.localStorageService.getAccessToken(forServer: currentServerURL) else {
            print("Token not found!"); return
        }
        
        let messageCreditions = MessageCreditions(token: token, userID: currentUserId, roomId: roomId)
        
        self.messages = []
        
        moyaProvider.request(.getChannelMessages(messageCreditions)) { [weak self] result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let messages = try JSONDecoder().decode(MessagesResponse.self, from: response.data)
                        guard !messages.messages.isEmpty else {
                            print("ChatSection: Fetched messages is empty!"); return
                        }
                        self?.messages = messages.messages.sorted { $0.ts < $1.ts }
                        
                    } catch let error {
                        print("Cant decode messages: \(error)")
                    }
                    
                } else {
                    print("Fetching messages status code: \(response.statusCode)")
                }
                
            case .failure(let error):
                print("Fetching messages error: \(error)")
            }
        }
    }
    
    func isMyMessageCheck(message: Message) -> Bool {
        guard let currentUsername = localStorageService.getUserInfo().first?.username else {
            print("CurrentUsername cannot be found"); return false
        }
        return message.u.username != currentUsername
    }
}
