//
//  UserService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

final class UserService {
    
    private var user: User?

    var isClientOnboarded: Bool = false
            
    private var serverCreditions: [ServerCreditions] {
        localStorageService.getAllServerCreds()
    }
    
    private let moyaProvider: MoyaProvider<RocketChatAPI>
    private let localStorageService: LocalStorageService
    
    
    init(
        moyaProvider: MoyaProvider<RocketChatAPI>,
        localStorageService: LocalStorageService
    ) {
        self.moyaProvider = moyaProvider
        self.localStorageService = localStorageService
        
        onboardingCheck()
    }
    
    func fetchUser(completion: ((User) -> Void)?) {
        guard let lastCredsURL = serverCreditions.first?.url else {
            print("ERROR: Last crend is not exists"); return
        }
        guard let prevToken = localStorageService.getAccessToken(forServer: lastCredsURL) else {
            print("ERROR: Cant find a previous token"); return
        }
        
        moyaProvider.request(.me(token: prevToken)) { [unowned self] result in
            switch result {
            case .success(let response):
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                    let user = User(
                        id: loginResponse.data.userID,
                        services: loginResponse.data.me.services,
                        emails: loginResponse.data.me.emails,
                        roles: loginResponse.data.me.roles,
                        status: loginResponse.status,
                        active: loginResponse.data.me.active,
                        updatedAt: loginResponse.data.me.updatedAt,
                        name: loginResponse.data.me.name,
                        username: loginResponse.data.me.username,
                        statusConnection: loginResponse.data.me.statusConnection,
                        utcOffset: loginResponse.data.me.utcOffset,
                        email: loginResponse.data.me.email,
                        settings: loginResponse.data.me.settings,
                        avatarURL: loginResponse.data.me.avatarURL
                    )
                    
                    // Send user
                    if response.statusCode == 200 {
                        completion?(user)
                    }
                    
                    // Save user info
                    self.localStorageService.save(userInfo: user)
                    
                } catch let error {
                    print("Cant fetch and save user: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    private func onboardingCheck() {
        self.isClientOnboarded = !localStorageService.getAllServerCreds().isEmpty
    }
}
