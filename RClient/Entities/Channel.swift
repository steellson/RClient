//
//  Channel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation

struct Channel: Codable, Hashable, Identifiable {
    
    let id: String
    let fname: String?
    let customFields: CustomFields?
    let description: String?
    let broadcast, encrypted: Bool?
    let name, t: String
    let msgs, usersCount: Int
    let u: ChannelU?
    let ts: String
    let ro, channelDefault: Bool
    let sysMes: [String]?
    let updatedAt, lm, announcement: String
    let muted: [String]?
    let teamID: String?
    let teamDefault, reactWhenReadOnly: Bool?
    let lastMessage: LastMessage?
    let usernames: [JSONAny]?
    let topic, jitsiTimeout: String?
    let joinCodeRequired: Bool?
    let streamingOptions: StreamingOptions?
    let announcementDetails: CustomFields?
    let archived: Bool?
    let unmuted: [String]?
    let featured: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fname, customFields, description, broadcast, encrypted, name, t, msgs, usersCount, u, ts, ro
        case channelDefault = "default"
        case sysMes
        case updatedAt = "_updatedAt"
        case lm, announcement, muted
        case teamID = "teamId"
        case teamDefault, reactWhenReadOnly, lastMessage, usernames, topic, jitsiTimeout, joinCodeRequired, streamingOptions, announcementDetails, archived, unmuted, featured
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Channel, rhs: Channel) -> Bool {
        lhs.id == rhs.id
    }
}

struct CustomFields: Codable {
}

struct UElement: Codable {
    let id, name, username: String
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, username, type
    }
}

struct StreamingOptions: Codable {
    let url: String
    let isAudioOnly: Bool
    let message, type: String
}

struct ChannelU: Codable {
    let id, username: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
    }
}
