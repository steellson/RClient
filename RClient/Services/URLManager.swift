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
//        case cantGetServerCreditions
//    }
    
    public enum UDKeys: String {
        case serverCreditions
    }
    
    @Published private(set) var serverCreds = [ServerCreditions]()
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
    
    func save(serverCreditions: ServerCreditions) {
        guard var creds = userDefaultsInstance.array(forKey: UDKeys.serverCreditions.rawValue) as? [ServerCreditions] else {
            print("DEBUG: Cant get creds from UD"); return
        }
        creds.append(serverCreditions)
        userDefaultsInstance.set(creds, forKey: UDKeys.serverCreditions.rawValue)
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
