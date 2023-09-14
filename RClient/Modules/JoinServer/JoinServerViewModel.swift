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
    @Published var isTokenExists: Bool = false
        
    private let urlManager: URLManager
    private let validationService: ValidationService

    private let moyaService: MoyaProvider<RocketChatAPI>
    
    private var anyCancellables: Set<AnyCancellable> = []

    init(
        urlManager: URLManager,
        validationService: ValidationService,
        moyaService: MoyaProvider<RocketChatAPI>
    ) {
        self.urlManager = urlManager
        self.validationService = validationService
        self.moyaService = moyaService
        
        validateInputUrl()
    }
    
    
    func setupServerCreditions() {
        urlManager.save(
            serverCreditions: ServerCreditions(url: serverUrl)
        )
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
