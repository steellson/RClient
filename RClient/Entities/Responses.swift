//
//  Responses.swift
//  RClient
//
//  Created by Andrew Steellson on 17.09.2023.
//

import Foundation

//MARK: - Login

struct LoginResponse: Codable {
    let status: String
    let data: DataClass
}


struct DataClass: Codable {
    let userID, authToken: String
    let me: User

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case authToken, me
    }
}


//MARK: - Reg

struct RegistrationResponse: Codable {
    let user: ResponseUser
    let success: Bool
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


//MARK: - Channels

struct ChannelsResponse: Codable {
    let channels: [Channel]
    let offset, count, total: Int
    let success: Bool
}

