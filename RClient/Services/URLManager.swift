//
//  URLManager.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine

final class URLManager {
    
//    enum URLManagerError: Error {
//        case cantValidateUrl
//        case cantGetCurrentUrl
//        case cantGetServerCreditions
//    }
    
    public enum UDKeys: String {
        case serverCreditions
    }
    
    @Published var serverCreds = [ServerCreditions]()
    @Published private(set) var isCredsEmpty: Bool = true
    
    private let userDefaultsInstance: UserDefaults
    
    private var anyCancellables = Set<AnyCancellable>()
    
    init(
        userDefaultsInstance: UserDefaults
    ) {
        self.userDefaultsInstance = userDefaultsInstance
        
        setupServerCreds()
        checkForCreds()
    }
}


extension URLManager {
    
    func validateUrl(urlString: String) -> Bool {
        urlString.starts(with: "https://")
        && urlString.contains(".")
        && urlString.count >= 15
    }
    
    
    // Subscriptins
    
    func checkForCreds() {
        userDefaultsInstance.array(forKey: UDKeys.serverCreditions.rawValue)
            .publisher
            .map { $0.isEmpty }
            .assign(to: \.isCredsEmpty, on: self)
            .store(in: &anyCancellables)
    }
    
    func setupServerCreds() {
        userDefaultsInstance.array(forKey: UDKeys.serverCreditions.rawValue)
            .publisher
            .map { $0 as? [ServerCreditions] ?? [] }
            .assign(to: \.serverCreds, on: self)
            .store(in: &anyCancellables)
    }
}
