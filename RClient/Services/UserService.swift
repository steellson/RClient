//
//  UserService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class UserService {
    
    let user: User?
    
    private let urlManager: URLManager
    
    init(
        urlManager: URLManager
    ) {
        self.user = nil
        self.urlManager = urlManager
    }
}


extension UserService {
    
    func isOnboarded() -> Bool {
        urlManager.check(item: .currentServerCreditions)
    }
}
