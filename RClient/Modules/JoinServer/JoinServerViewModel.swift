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
    private let moyaService: MoyaProvider<RocketChatAPI>
    
    private var anyCancellables: Set<AnyCancellable> = []

    init(
        urlManager: URLManager,
        moyaService: MoyaProvider<RocketChatAPI>
    ) {
        self.urlManager = urlManager
        self.moyaService = moyaService
        
        validateInputUrl()
    }
    
    private func validateInputUrl() {
        $serverUrl
            .dropFirst()
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .map { [unowned self] urlString in
                self.urlManager.validateUrl(urlString: urlString)
            }
            .assign(to: \.isValidUrl, on: self)
            .store(in: &anyCancellables)
    }
    
    func setupServerCreditions() {
        urlManager.save(
            serverCreditions: ServerCreditions(url: serverUrl),
            identity: UUID().uuidString
        )
    }
}


