//
//  RClientAppViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine

final class RClientAppViewModel: ObservableObject {
    
    var isUserOnboarded: Bool {
        userService.isUserOnboarded
    }
    
    var isUserAuthorized: Bool {
        userService.isUserAuthorized
    }
    
    private let userService: UserService
        
    init(
        userService: UserService
    ) {
        self.userService = userService
    }
}
