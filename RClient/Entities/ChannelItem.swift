//
//  Channel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation

struct ChannelItem: Identifiable {
    let id: String
    let name: String
    let iconName: String?
}

struct Channel: Codable {
    let id, name: String
    let t: T
    let msgs: Int
    let u: U
    let customFields: CustomFields?
    let ts: String
    let ro: Bool?
    let updatedAt: String
    let lm: String?
    let usersCount: Int
    let lastMessage: LastMessage?
    let fname: String?
    let channelDefault: Bool?
    let muted: [String]?
    let broadcast, encrypted: Bool?
    let sysMes: SysMes?
    let jitsiTimeout, topic: String?
    let joinCodeRequired: Bool?
    let avatarETag, avatarOrigin: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, t, msgs, u, customFields, ts, ro
        case updatedAt = "_updatedAt"
        case lm, usersCount, lastMessage, fname
        case channelDefault = "default"
        case muted, broadcast, encrypted, sysMes, jitsiTimeout, topic, joinCodeRequired, avatarETag, avatarOrigin
    }
}

struct CustomFields: Codable {
}

