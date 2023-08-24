//
//  URLManager.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class URLManager {
    
    enum URLManagerError: Error {
        case cantGetCurrentUrl
    }
        
    public enum UDKeys: String {
        case currentServerUrl
    }
        
    private let userDefaultsInstance: UserDefaults
    
    init(userDefaultsInstance: UserDefaults) {
        self.userDefaultsInstance = userDefaultsInstance
    }
}


extension URLManager {
    
    func save(currentServerUrl: String) {
        userDefaultsInstance.set(currentServerUrl, forKey: UDKeys.currentServerUrl.rawValue)
        print("Current server URL: \(userDefaultsInstance.object(forKey: UDKeys.currentServerUrl.rawValue)!) succsesfully saved!")
    }
    
    func getCurrentServerUrl() throws -> String? {
        guard let currentUrl = userDefaultsInstance.string(forKey: UDKeys.currentServerUrl.rawValue) else {
            throw URLManagerError.cantGetCurrentUrl
        }
        return currentUrl
    }
    
    func check(item forKey: UDKeys) -> Bool {
        userDefaultsInstance.object(forKey: forKey.rawValue) != nil
    }
}
