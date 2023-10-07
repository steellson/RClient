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
    
    @Published var isUserAuthorized: Bool  = false
    
    private let userService: UserService
    private let localStorageService: LocalStorageService
    private let navigationStateService: NavigationStateService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        userService: UserService,
        localStorageService: LocalStorageService,
        navigationStateService: NavigationStateService
    ) {
        self.userService = userService
        self.localStorageService = localStorageService
        self.navigationStateService = navigationStateService
        
        isUserOnboarded = userService.isClientOnboarded
        isUserAuthorized = !localStorageService.getUserInfo().isEmpty
        
        Publishers.CombineLatest($isUserOnboarded, $isUserAuthorized)
            .sink { [unowned self] isOnboarded, isAuthorized in
                if isOnboarded && isAuthorized {
                    self.navigationStateService.globalState = .root
                } else if isOnboarded && !isAuthorized {
                    self.navigationStateService.globalState = .login
                } else {
                    self.navigationStateService.globalState = .joinWelcomeServer
                }
            }
            .store(in: &cancellables)
    }
}
