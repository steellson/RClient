//
//  UserService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class UserService {

    var isUserOnboarded: Bool {
        !localStorageManager.getAllServerCreds().isEmpty
    }
    
    var isUserAuthorized: Bool {
        (localStorageManager.getAccessToken(for: serverCreditions.first?.url) != nil)
    }
        
    private var serverCreditions: [ServerCreditions] {
        localStorageManager.getAllServerCreds()
    }
    
    private let localStorageManager: LocalStorageService
    
    
    init(
        localStorageManager: LocalStorageService
    ) {
        self.localStorageManager = localStorageManager

    }
}
