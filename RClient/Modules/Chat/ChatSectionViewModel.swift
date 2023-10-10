//
//  ChatSectionViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation
import Combine

final class ChatSectionViewModel: ObservableObject {
            
    @Published var messages: [Message] = []
    
    private let apiService: APIService
    private let localStorageService: LocalStorageService
    private let navigationStateService: NavigationStateService
    private let userService: UserService
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        apiService: APIService,
        localStorageService: LocalStorageService,
        navigationStateService: NavigationStateService,
        userService: UserService
    ) {
        self.apiService = apiService
        self.localStorageService = localStorageService
        self.navigationStateService = navigationStateService
        self.userService = userService
        
        setupDataFromSelectionSubsctiption()
    }
    
    func isMyMessageCheck(message: Message) -> Bool {
        guard let currentUsername = localStorageService.getUserInfo().first?.username else {
            print("CurrentUsername cannot be found"); return false
        }
        return message.u.username != currentUsername
    }

    private func fetchMessages(forRoom roomId: String, server serverURL: String, user userID: String) {
        guard let token = self.localStorageService.getAccessToken(forServer: serverURL) else {
            print("Token not found!"); return
        }
        
        self.messages = []
        let messageCreditions = MessageCreditions(token: token, userID: userID, roomId: roomId)

        apiService.fetchChatMessages(with: messageCreditions) { [weak self] result in
            switch result {
            case .success(let messageResponse):
                self?.messages = messageResponse.messages.sorted { $0.ts < $1.ts }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

//MARK: - Subscriptions

private extension ChatSectionViewModel {

    func setupDataFromSelectionSubsctiption() {
        Publishers.CombineLatest3(
            navigationStateService.$selectedServer,
            navigationStateService.$selectedChannel,
            userService.$user
            )
            .sink { [unowned self] server, channel, user in
                guard let server = server,
                      let channel = channel,
                      let user = user else { return }
                self.fetchMessages(forRoom: channel.id, server: server.url, user: user.id)
            }
            .store(in: &subscriptions)
    }
}
