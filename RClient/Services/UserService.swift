//
//  UserService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine

final class UserService {
    
    @Published var isUserOnboarded: Bool = false
    @Published var isUserauthorized: Bool = false
        
    private let localStorageManager: LocalStorageManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        localStorageManager: LocalStorageManager
    ) {
        self.localStorageManager = localStorageManager

        localStorageManager.$isCredsEmpty
            .removeDuplicates()
            .map { !$0 }
            .assign(to: \.isUserOnboarded, on: self)
            .store(in: &cancellables)
    }
}
