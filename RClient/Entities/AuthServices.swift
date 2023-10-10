//
//  AuthServices.swift
//  RClient
//
//  Created by Andrew Steellson on 17.09.2023.
//

import Foundation

struct Email: Codable {
    let address: String
    let verified: Bool
}

struct Email2Fa: Codable {
    let enabled: Bool
}

struct Password: Codable {
    let bcrypt: String
}


// MARK: - Services

struct Services: Codable {
    let password: Password
    let email2Fa: Email2Fa

    enum CodingKeys: String, CodingKey {
        case password
        case email2Fa = "email2fa"
    }
}
