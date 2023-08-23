//
//  UserService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class UserService {
    
    private var user: User?
    private let urlManager = URLManager()
}


extension UserService {
    
    func isOnboarded() -> Bool {
        urlManager.check(item: .currentServerUrl)
    }
}
