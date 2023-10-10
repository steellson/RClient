//
//  RClientAppViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine

final class RClientAppViewModel: ObservableObject {
                
    @Published var globalState: GlobalState? = nil
    
    private let userService: UserService
    private let navigationStateService: NavigationStateService
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        userService: UserService,
        navigationStateService: NavigationStateService
    ) {
        self.userService = userService
        self.navigationStateService = navigationStateService
        
        
        setupNavigationStateSubscribe()
        setupCurrentStateSubscribe()
    }
}

//MARK: - Subscriptions

private extension RClientAppViewModel {
    
    func setupNavigationStateSubscribe() {
        navigationStateService.$globalState
            .assign(to: \.globalState, on: self)
            .store(in: &subscriptions)
    }
    
    func setupCurrentStateSubscribe() {
        userService.$user
            .sink { [unowned self] user in
                self.navigationStateService.globalState = user != nil
                ? .root
                : .root
            }
            .store(in: &subscriptions)
    }
}
