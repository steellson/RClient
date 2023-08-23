//
//  RClientAppViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class RClientAppViewModel: ObservableObject {
    
    private let userService = UserService()
    
    func isClientOnboarded() -> Bool {
        userService.isOnboarded()
    }
}
