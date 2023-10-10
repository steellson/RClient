//
//  Forms.swift
//  RClient
//
//  Created by Andrew Steellson on 17.09.2023.
//

import Foundation

struct UserLoginForm: Codable {
    let user: String?
    let password: String?
    let resume: String?
}

struct Me: Codable {
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

struct UserRegistrationForm: Codable {
    var email: String
    var pass: String
    var username: String?
    var name: String?
}
