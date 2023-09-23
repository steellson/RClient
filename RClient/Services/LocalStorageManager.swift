//
//  LocalStorageManager.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine

final class LocalStorageManager {
    
    public enum UDKeys: String {
        case serverCreditions
//        case userInfo
    }
    
    @Published private(set) var serverCreditions: [ServerCreditions] = []
    @Published private(set) var isCredsEmpty: Bool = true
    
    @Published private(set) var isCurrentUserAuthorized: Bool = false
    
    private let userDefaultsInstance: UserDefaults
    private var keyChainService: KeyChainService?
    
    private var anyCancellables = Set<AnyCancellable>()
    
    init(
        userDefaultsInstance: UserDefaults,
        keyChainService: KeyChainService?
    ) {
        self.userDefaultsInstance = userDefaultsInstance
        self.keyChainService = keyChainService
        
        checkForCreds()
        
        #warning("debug")
        print("*** ALL CREDS:\n\(getAllServerCreds().compactMap { $0 }) ***\n")
    }
    
}

//MARK: - Server creds access

extension LocalStorageManager {
    
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

extension LocalStorageManager {
    
    func getAccessToken(for serverUrl: String) -> String? {
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

//MARK: - Subscriptions Extension

extension LocalStorageManager {
    
    private func checkForCreds() {
        userDefaultsInstance.object(forKey: UDKeys.serverCreditions.rawValue)
            .publisher
            .map { ($0 as? [ServerCreditions])?.isEmpty ?? false }
            .assign(to: \.isCredsEmpty, on: self)
            .store(in: &anyCancellables)
    }
    
    func getCreds() {
        userDefaultsInstance.object(forKey: UDKeys.serverCreditions.rawValue)
            .publisher
            .map { ($0 as? [ServerCreditions]) ?? [ServerCreditions]() }
            .assign(to: \.serverCreditions, on: self)
            .store(in: &anyCancellables)
    }
}
