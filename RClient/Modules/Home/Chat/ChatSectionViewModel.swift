//
//  ChatSectionViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation
import Moya

final class ChatSectionViewModel: ObservableObject {
    
    @Published var chat: ChannelItem? {
        willSet {
            guard let newValue = newValue else {
                print("nil comes to chat"); return
            }
            print(newValue.id)
            self.fetchMessages(withRoomID: newValue.id)
        }
    }
    @Published var messages: [Message] = [] {
        didSet {
            print(messages)
        }
    }
    
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
        guard let currentUserId = localStorageService.getUserInfo().map({ $0 }).first?.id else {
            print("CurrentUserID cannot be found"); return
        }
        guard let currentServerURL = self.localStorageService.getAllServerCreds().first?.url else {
            print("CurrentServerURL is not found"); return
        }
        guard let token = self.localStorageService.getAccessToken(forServer: currentServerURL) else {
            print("Token not found!"); return
        }
        
        moyaProvider.request(.getChannelMessages(token: token, userID: currentUserId, roomId: roomId)) { [weak self] result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let messages = try JSONDecoder().decode(MessagesResponse.self, from: response.data)
                        guard !messages.messages.isEmpty else {
                            print("ChatSection: Fetched messages is empty!"); return
                        }
                        messages.messages.forEach { message in
                            self?.messages.append(
                                Message(
                                    id: message.id,
                                    t: message.t,
                                    rid: message.rid,
                                    ts: message.ts,
                                    msg: message.msg,
                                    u: message.u,
                                    groupable: message.groupable,
                                    updatedAt: message.updatedAt,
                                    urls: message.urls,
                                    mentions: message.mentions,
                                    channels: message.channels,
                                    md: message.md,
                                    tmid: message.tmid,
                                    tshow: message.tshow,
                                    replies: message.replies,
                                    tcount: message.tcount,
                                    tlm: message.tlm
                                )
                                
//                                Message(
//                                    id: message.id,
//                                    rid: message.rid,
//                                    msg: message.msg,
//                                    ts: message.ts,
//                                    u: message.u,
//                                    updatedAt: message.updatedAt,
//                                    editedAt: message.editedAt,
//                                    editedBy: message.editedBy,
//                                )
                            )
                        }
                        
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
}
