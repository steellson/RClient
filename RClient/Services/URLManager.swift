//
//  URLManager.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class URLManager {
    
    enum URLManagerError: Error {
        case cantValidateUrl
        case cantGetCurrentUrl
    }
        
    public enum UDKeys: String {
        case currentServerCreditions
    }
        
    private let userDefaultsInstance: UserDefaults
    
    init(userDefaultsInstance: UserDefaults) {
        self.userDefaultsInstance = userDefaultsInstance
    }
}


extension URLManager {
    
    func validateUrl(urlString: String) -> Bool {
        urlString.starts(with: "https://")
        && urlString.contains(".")
        && urlString.count >= 15
    }
    
    func save(serverCreditions: ServerCreditions) throws {
        guard validateUrl(urlString: serverCreditions.url) else {
            throw URLManagerError.cantValidateUrl
        }
        userDefaultsInstance.set(serverCreditions, forKey: UDKeys.currentServerCreditions.rawValue)
        print("URL is valid! Current creditionals: \(serverCreditions) saved!")
    }
    
    func getCurrentServerCreditions() throws -> ServerCreditions? {
        guard let currentServerCreditions = userDefaultsInstance.object(forKey: UDKeys.currentServerCreditions.rawValue) as? ServerCreditions else {
            throw URLManagerError.cantGetCurrentUrl
        }
        return currentServerCreditions
    }
    
    func check(item forKey: UDKeys) -> Bool {
        userDefaultsInstance.object(forKey: forKey.rawValue) != nil
    }
}
