//
//  UserKeys.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import Foundation

struct User: Codable, Stored {
    let id: String
    let services: Services
    let emails: [Email]
    let roles: [String]
    let status: String
    let active: Bool
    let updatedAt, name, username, statusConnection: String
    let utcOffset: Int
    let email: String
    let settings: Settings
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case services, emails, roles, status, active
        case updatedAt = "_updatedAt"
        case name, username, statusConnection, utcOffset, email, settings
        case avatarURL = "avatarUrl"
    }
}


// MARK: - U

struct U: Codable {
    let id, username: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
    }
}

struct Profile: Codable {
}




