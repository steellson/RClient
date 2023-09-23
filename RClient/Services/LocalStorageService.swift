//
//  LocalStorageService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation

final class LocalStorageService {
    
    public enum UDKeys: String {
        case serverCreditions
//        case userInfo
    }
    
    private let userDefaultsInstance: UserDefaults
    private var keyChainService: KeyChainService?
    
    
    init(
        userDefaultsInstance: UserDefaults,
        keyChainService: KeyChainService?
    ) {
        self.userDefaultsInstance = userDefaultsInstance
        self.keyChainService = keyChainService
                
        #warning("debug")
        print("*** ALL CREDS:\n\(getAllServerCreds().compactMap { $0 }) ***\n")
    }
    
}

//MARK: - Server creds access

extension LocalStorageService {
    
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

//MARK: - KeyChain access

extension LocalStorageService {
    
    func getAccessToken(for serverUrl: String?) -> String? {
        guard let serverUrl = serverUrl else {
            print("ERROR: URL doesn't exits"); return nil
        }
        
        do {
            guard let token = try keyChainService?.getCreditions(forServer: serverUrl) else {
                print("ERROR: Cant find a server for current url"); return "Internal error!"
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
            try keyChainService?.saveCreditions(serverUrl: serverUrl, token: tokenData)
            print("*** TOKEN SAVED! *** \n")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
