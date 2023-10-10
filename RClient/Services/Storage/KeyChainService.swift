//
//  KeyChainService.swift
//  RClient
//
//  Created by Andrew Steellson on 17.09.2023.
//

import Foundation

final class KeyChainService {
    
    enum KeyChainError: Error {
        case itemNotFound
        case duplicateItems
        case unknown(status: OSStatus)
    }
    
    func saveCreditions(serverUrl: String, token: Data) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "RClient: \(serverUrl)" as AnyObject,
            kSecValueData as String: token as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else { throw KeyChainError.duplicateItems }
        guard status == errSecSuccess else { throw KeyChainError.unknown(status: status) }
    }
    
    func getCreditions(forServer serverUrl: String) throws -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "RClient: \(serverUrl)" as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else { throw KeyChainError.unknown(status: status) }
        return result as? Data
    }
    
    func removeCreds(forServer serverUrl: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "RClient: \(serverUrl)" as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status != errSecItemNotFound else { throw KeyChainError.itemNotFound }
        guard status == errSecSuccess else { throw KeyChainError.unknown(status: status) }
        print("Deleted!")
    }
}
