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
    private var keyChainService: KeyChainService?
    
    
    init(
        userDefaultsInstance: UserDefaults,
        keyChainService: KeyChainService?
    ) {
        self.userDefaultsInstance = userDefaultsInstance
        self.keyChainService = keyChainService
                
        print("*** ServerItems:\(getAllServerItems().compactMap { $0 }) ***")
//        print("*** USER INFO:\(getUserInfo().compactMap { $0 }) ***")
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
        
        if serverItems.isEmpty {
            serverItems.append(serverItem)
            let encodedServerItems = try? JSONEncoder().encode(serverItems)
            userDefaultsInstance.set(encodedServerItems, forKey: UDKeys.serverItems.rawValue)
        } else {
            serverItems.forEach { server in
                if server.url != serverItem.url {
                    let encodedServerItem = try? JSONEncoder().encode(serverItems)
                    userDefaultsInstance.set(encodedServerItem, forKey: UDKeys.serverItems.rawValue)
                } else {
                    print("ERROR: URL already exists!")
                }
            }
        }
    }
    
    func save(userInfo: User) {
        var info = getUserInfo()
        
        if info.isEmpty {
            info.append(userInfo)
            let encodedUserInfo = try? JSONEncoder().encode(info)
            userDefaultsInstance.set(encodedUserInfo, forKey: UDKeys.userInfo.rawValue)
            
            print(getUserInfo())
        } else {

            info.forEach { user in
                if user.email != userInfo.email {
                    let encodedUserInfo = try? JSONEncoder().encode(info)
                    userDefaultsInstance.set(encodedUserInfo, forKey: UDKeys.userInfo.rawValue)
                    
                    print(getUserInfo())
                } else {
                    print("ERROR: Email already exists!")
                }
            }
        }
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
                print("ERROR: Cant find a server for current url!"); return "Internal error!"
            }
            
            let decodedToken = String(data: token, encoding: .utf8)
            print("*** KeyChain creds: \(String(describing: decodedToken)) ***\n")
            return decodedToken ?? nil
        } catch let error {
            print(error.localizedDescription)
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
            print(error.localizedDescription)
        }
    }
}
