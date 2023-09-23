//
//  UserService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class UserService {

    var isUserOnboarded: Bool {
        !localStorageService.getAllServerCreds().isEmpty
    }
    
    var isUserAuthorized: Bool {
        (localStorageService.getAccessToken(for: serverCreditions.first?.url) != nil)
    }
        
    private var serverCreditions: [ServerCreditions] {
        localStorageService.getAllServerCreds()
    }
    
    private let localStorageService: LocalStorageService
    
    
    init(
        localStorageService: LocalStorageService
    ) {
        self.localStorageService = localStorageService

    }
}
