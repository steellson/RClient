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


struct ResponseUser: Codable {
    let id, type, status: String
    let active: Bool
    let name, username: String
    let rooms: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type, status, active, name, username
        case rooms = "__rooms"
    }
}

struct Profile: Codable {
}




