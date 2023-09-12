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
    
    func validateUrl(urlString: String) -> Bool {
        urlString.starts(with: "https://")
        && urlString.contains(".")
        && urlString.count >= 15
    }
    
    func getAllServerCreds() -> CreditionsStorage {
        if let credsData = userDefaultsInstance.object(forKey: UDKeys.serverCreditions.rawValue) as? Data {
            
            guard let creds = try? JSONDecoder().decode(CreditionsStorage.self, from: credsData) else {
                print("DEBUG: Cant get creds from data"); return [:]
            }
            return creds
            
        } else {
            return [:]
        }
    }
    
    func save(serverCreditions: ServerCreditions, identity: String) {
        var creds = getAllServerCreds()
        
        if creds.keys.count > 0 {
            creds.keys.forEach { key in
                
                if key == identity {
                    print("ERROR: Identity already exist. Must be re-writed")
                } else {
                    creds[identity] = serverCreditions
                    let encodedCreds  = try? JSONEncoder().encode(creds)
                    userDefaultsInstance.set(encodedCreds, forKey: UDKeys.serverCreditions.rawValue)
                }
            }
        } else {
            creds[identity] = serverCreditions
            let encodedCreds  = try? JSONEncoder().encode(creds)
            userDefaultsInstance.set(encodedCreds, forKey: UDKeys.serverCreditions.rawValue)
        }
    }
}

//MARK: - Private Subscriptions Extension

private extension URLManager {
    
    func checkForCreds() {
        userDefaultsInstance.object(forKey: UDKeys.serverCreditions.rawValue)
            .publisher
            .map { ($0 as? CreditionsStorage)?.isEmpty ?? false }
            .assign(to: \.isCredsEmpty, on: self)
            .store(in: &anyCancellables)
    }
    
}
