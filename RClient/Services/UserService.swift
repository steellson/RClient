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
        
    private let urlManager: URLManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        urlManager: URLManager
    ) {
        self.urlManager = urlManager

        urlManager.$isCredsEmpty
            .removeDuplicates()
            .map { !$0 }
            .assign(to: \.isUserOnboarded, on: self)
            .store(in: &cancellables)
    }
}
