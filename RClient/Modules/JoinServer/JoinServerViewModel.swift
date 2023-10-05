//
//  JoinServerViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya
import Combine

final class JoinServerViewModel: ObservableObject {
    
    @Published var serverUrl: String = ""
    
    @Published var isValidUrl: Bool = false
    @Published var alertIsPresented: Bool = false
        
    private let localStorageService: LocalStorageService
    private let validationService: ValidationService
    private let moyaService: MoyaProvider<RocketChatAPI>
    private let navigationStateService: NavigationStateService
    
    private var anyCancellables: Set<AnyCancellable> = []

    init(
        localStorageService: LocalStorageService,
        validationService: ValidationService,
        moyaService: MoyaProvider<RocketChatAPI>,
        navigationStateService: NavigationStateService
    ) {
        self.localStorageService = localStorageService
        self.validationService = validationService
        self.moyaService = moyaService
        self.navigationStateService = navigationStateService
        
        validateInputUrl()
    }
    
    
    func setupServerCreditions() {
        localStorageService.save(
            serverCreditions: ServerCreditions(url: serverUrl)
        )
        navigationStateService.globalState = .login
    }
}

//MARK: - Subscriptions

private extension JoinServerViewModel {
    
    private func validateInputUrl() {
        $serverUrl
            .dropFirst()
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .map { [validationService] urlString in
                validationService.validate(urlString, method: .urlString)
            }
            .assign(to: \.isValidUrl, on: self)
            .store(in: &anyCancellables)
    }
    
}
