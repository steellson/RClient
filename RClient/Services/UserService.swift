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
    @Published var isUserAuthorized: Bool = false
        
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
        

        guard let lastCreditions = localStorageManager.getAllServerCreds().first else {
            print("ERROR: Current url is not found"); return
        }
        
        localStorageManager.getAccessToken(for: lastCreditions.url)
            .publisher
            .map {
                print("****************** \($0)")
                return $0.count != 0
            }
            .assign(to: \.isUserAuthorized, on: self)
            .store(in: &cancellables)
    }
}
