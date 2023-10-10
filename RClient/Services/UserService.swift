//
//  UserService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

final class UserService {
    
    @Published var user: User?
    
    private var serverItems: [ServerItem]? {
        localStorageService.getAllServerItems()
    }
    private var lastServer: ServerItem? {
        serverItems?.first
    }
    
    private let apiService: APIService
    private let localStorageService: LocalStorageService
    
    
    init(
        apiService: APIService,
        localStorageService: LocalStorageService
    ) {
        self.apiService = apiService
        self.localStorageService = localStorageService
        
        setupPreviousSession()
    }
    
    private func setupPreviousSession() {
        guard let lastServer = lastServer else {
            print("Coudnt find last server"); return
        }
        guard let prevToken = localStorageService.getAccessToken(forServer: lastServer.url) else {
            print("ERROR: Cant find a previous token"); return
        }

        apiService.loginWithToken(prevToken, serverUrl: lastServer.url) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                print("User \(user.email) sucsessfully loggined!")
            case .failure(let error):
                print("ERROR: Cant login with previous token \(error)")
            }
        }
    }
}
