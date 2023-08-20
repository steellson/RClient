//
//  Room.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import Foundation

struct Room {
    
    enum RoomType: String {
        case c, d, p, l, v
    }
    
    let _id: String
    let t: RoomType
    let name: String?
    let fname: String?
    let msgs: Int
    let `default`: Bool? = true
    let broadcast: Bool? = true
    let featured: Bool? = true
    let announcement: String?
    let joinCodeRequired: Bool?
    let announcementDetails: [String?:String]
    var encrypted: Bool?
    let topic: String?
    let reactWhenReadOnly: Bool?
    let sysMes: Bool?
    let u: UserShort
    let uids: [String]?
    let lastMessage: Message?
    let lm: Date?
    let usersCount: Int
    let callStatus: CallStatus?
    let webRtcCallStartTime: Date?
    let servedBy: [String: String]?
    let streamingOptions: StreamingOptions?
    let prid: String?
    let avatarETag: String?
    var teamMain: Bool?
    let teamId: String?
    let teamDefault: Bool?
    var open: Bool?
    let autoTranslateLanguage: String?
    var autoTranslate: Bool?
    let unread: Int?
    var alert: Bool?
    var hideUnreadStatus: Bool?
    var hideMentionStatus: Bool?
    var muted: [String]?
    var unmuted: [String]?
    var usernames: [String]?
    let ts: Date?
    var cl: Bool?
    var ro: Bool?
    var favorite: Bool?
    var archived: Bool?
    let description: String?
    var createdOTR: Bool?
    let e2eKeyId: String?
    var federated: Bool?
    let channel: [String:String]
    
//    let customFields: CustomFields
}

enum CallStatus: String {
    case ringing
    case ended
    case declined
    case ongoing
}

struct StreamingOptions {
    let id: String?
    let type: String?
    let url: String?
    let thumbnail: String?
    let isAudioOnly: Bool?
    let message: String?
}
