//
//  URLManager.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine

final class URLManager {
    
    public enum UDKeys: String {
        case serverCreditions
    }
    
    @Published private(set) var isCredsEmpty: Bool = true
    
    private let userDefaultsInstance: UserDefaults
    
    private var anyCancellables = Set<AnyCancellable>()
    
    init(
        userDefaultsInstance: UserDefaults
    ) {
        self.userDefaultsInstance = userDefaultsInstance
        
        checkForCreds()
        
        #warning("debug")
        print("*** ALL CREDS:\n\(getAllServerCreds().compactMap { $0 }) ***\n")
    }
    
}


extension URLManager {
    
    func getAllServerCreds() -> [ServerCreditions] {
        if let credsData = userDefaultsInstance.object(forKey: UDKeys.serverCreditions.rawValue) as? Data {
            
            guard let creds = try? JSONDecoder().decode([ServerCreditions].self, from: credsData) else {
                print("DEBUG: Cant get creds from data"); return []
            }
            return creds
            
        } else {
            return []
        }
    }
    
    func save(serverCreditions: ServerCreditions) {
        
        var creds = getAllServerCreds()
        
        if creds.isEmpty {
            
            creds.append(serverCreditions)
            let encodedCreds = try? JSONEncoder().encode(creds)
            userDefaultsInstance.set(encodedCreds, forKey: UDKeys.serverCreditions.rawValue)
        } else {
            
            creds.forEach { cred in
                if cred.url != serverCreditions.url {
                    let encodedCreds = try? JSONEncoder().encode(creds)
                    userDefaultsInstance.set(encodedCreds, forKey: UDKeys.serverCreditions.rawValue)
                } else {
                    print("ERROR: URL already exists!")
                }
            }
        }
    }
}

//MARK: - Private Subscriptions Extension

private extension URLManager {
    
    func checkForCreds() {
        userDefaultsInstance.object(forKey: UDKeys.serverCreditions.rawValue)
            .publisher
            .map { ($0 as? [ServerCreditions])?.isEmpty ?? false }
            .assign(to: \.isCredsEmpty, on: self)
            .store(in: &anyCancellables)
    }
    
}
