//
//  Channel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation

struct Channel: Codable {
    let id, name, t: String
    let usernames: [String]
    let msgs: Int
    let u: U
    let ts: String
    let ro, sysMes: Bool
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, t, usernames, msgs, u, ts, ro, sysMes
        case updatedAt = "_updatedAt"
    }
}

struct ChannelItem: Identifiable {
    let id: String
    let name: String
    let iconName: String?
}

