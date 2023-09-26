//
//  RClientAppViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class RClientAppViewModel: ObservableObject {
        
    var isUserOnboarded: Bool {
        userService.isClientOnboarded
    }
    
    var isUserAuthorized: Bool {
        !localStorageService.getUserInfo().isEmpty
    }
    
    private(set) var minHeight: CGFloat = 300

    
    private let userService: UserService
    private let localStorageService: LocalStorageService
        
    init(
        userService: UserService,
        localStorageService: LocalStorageService
    ) {
        self.userService = userService
        self.localStorageService = localStorageService
    }
}
