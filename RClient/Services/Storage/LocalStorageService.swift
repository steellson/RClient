//
//  LocalStorageService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class LocalStorageService {
    
    public enum UDKeys: String {
        case serverItems
        case userInfo
    }
    
    private let userDefaultsInstance: UserDefaults
    private let keyChainService: KeyChainService?
    
    
    init(
        userDefaultsInstance: UserDefaults,
        keyChainService: KeyChainService?
    ) {
        self.userDefaultsInstance = userDefaultsInstance
        self.keyChainService = keyChainService
    }
}

//MARK: - UserDefaults access

extension LocalStorageService {
    
    func getAllServerItems() -> [ServerItem] {
        if let itemsData = userDefaultsInstance.object(forKey: UDKeys.serverItems.rawValue) as? Data {
            guard let serverItems = try? JSONDecoder().decode([ServerItem].self, from: itemsData) else {
                print("DEBUG: Cant get server items from data"); return []
            }
            return serverItems
        } else {
            return []
        }
    }
    
    func getUserInfo() -> [User] {
        if let userInfoData = userDefaultsInstance.object(forKey: UDKeys.userInfo.rawValue) as? Data {
            guard let userInfo = try? JSONDecoder().decode([User].self, from: userInfoData) else {
                print("DEBUG: Cant get user info from data"); return []
            }
            return userInfo
        } else {
            return []
        }
    }
    
    func save(serverItem: ServerItem) {
        var serverItems = getAllServerItems()
        serverItems.append(serverItem)
        
        let encodedServerItems = try? JSONEncoder().encode(serverItems)
        userDefaultsInstance.set(encodedServerItems, forKey: UDKeys.serverItems.rawValue)
    }
    
    func save(userInfo: User) {
        var info = getUserInfo()
        info.append(userInfo)
        
        let encodedUserInfo = try? JSONEncoder().encode(info)
        userDefaultsInstance.set(encodedUserInfo, forKey: UDKeys.userInfo.rawValue)
    }
}

//MARK: - KeyChain access

extension LocalStorageService {
    
    func getAccessToken(forServer serverUrl: String?) -> String? {
        guard let serverUrl = serverUrl else {
            print("ERROR: URL doesn't exits"); return nil
        }
        
        do {
            guard let token = try keyChainService?.getCreditions(forServer: serverUrl) else {
                print("ERROR: Cant find a token of server for current url!"); return "Internal error!"
            }
            
            let decodedToken = String(data: token, encoding: .utf8)
            return decodedToken ?? nil
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func saveAccessToken(forServer serverUrl: String, token: String) {
        guard let tokenData = token.data(using: .utf8) else {
            print("ERROR: Cant encode token to data"); return
        }
        do {
            try keyChainService?.saveCreditions(
                serverUrl: serverUrl,
                token: tokenData
            )
            print("*** TOKEN SAVED! *** \n")
        } catch let error {
            print("ERROR: Cant save token for reason: \(error)")
        }
    }
}
