//
//  RClientAppViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine

final class RClientAppViewModel: ObservableObject {
    
    @Published var isUserOnboarded: Bool = false
    
    private let userService: UserService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        userService: UserService
    ) {
        self.userService = userService
        
        userService.$isUserOnboarded
            .removeDuplicates()
            .assign(to: \.isUserOnboarded, on: self)
            .store(in: &cancellables)
    }
}
