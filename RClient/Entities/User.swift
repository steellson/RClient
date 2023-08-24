//
//  User.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import Foundation

struct User: Codable {
    
    let _id: String
    let email: String
    let password: String
    
}

//struct User: Codable {
//
//    enum UserStatus: String, Codable {
//        case online
//        case offline
//    }
//
//    let _id: String
//    let createdAt: Date
//    var roles: [String]
//    let type: String
//    var active: Bool
//    let username: String?
//    let nickname: String?
//    let name: String?
//    let services: [String: [String: String]]?
//    var emails: [UserEmail]?
//    let status: UserStatus?
//    let statusConnection: String?
//    let lastLogin: Date?
//    let bio: String?
//    let avatarOrigin: String?
//    let avatarETag: String?
//    let avatarUrl: String?
//    let utcOffset: Int?
//    let language: String?
//    let statusDefault: UserStatus?
//    let statusText: String?
//    let oauth: OAuth?
//    let _updatedAt: Date
//    let e2e: E2e?
//    var requirePasswordChange: Bool?
//    let settings: [String: String]?
//    let defaultRoom: String?
//    var ldap: Bool?
//    let `extension`: String?
//    let inviteToken: String?
//    var canViewAllInfo: Bool?
//    let phone: String?
//    let reason: String?
//    var federated: Bool?
//    let federation: Federation?
//    var importIds: [String]?
//    var __rooms: [String]?
//    let banners: [Banner]?          // ???
    
    //    let customFields: CustomFields?
//}


// MARK: - Other

struct UserShort: Codable {
    let _id: String
    let username: String
}

struct UserEmail: Codable {
    let address: String
    let verified: Bool
}

struct OAuth: Codable {
    let authorizedClient: [String]
}

struct E2e: Codable {
    
    enum StatusValue: String, Codable {
        case pending
        case done
    }
    
    let private_key: String
    let public_key: String
}

struct Federation: Codable {
    let avatarUrl: String?
    let searchedServerNames: [String]?
}

struct Banner: Codable {
    
    enum Modifier: String, Codable {
        case large
        case danger
    }
    
    let id: String
    let priority: Int
    let title: String
    let text: String
    let textArguments: [String]?
    let modifiers: [Modifier]
}
