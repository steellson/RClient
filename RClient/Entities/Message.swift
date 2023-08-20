//
//  Message.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import Foundation

struct Message {
    
    enum MentionType: String {
        case user, team
    }
    
    enum MessageSurfaceLayout: String {
        case message = "message"
    }
    
    enum MessageTypesValue: String {
       case e2e = "e2e"
       case uj = "uj"
       case ul = "ul"
       case ru = "ru"
       case au = "au"
       case mute_unmute = "mute_unmute"
       case r = "r"
       case ut = "ut"
       case wm = "wm"
       case rm = "rm"
       case subscription_role_added = "subscription-role-added"
       case subscription_role_removed = "subscription-role-removed"
       case room_archived = "room-archived"
       case room_unarchived = "room-unarchived"
       case room_chaned_privacy = "room_changed_privacy"
       case room_changed_description = "room_changed_description"
       case room_changed_announcement = "room_changed_announcement"
       case room_changed_avatar = "room_changed_avatar"
       case room_changed_topic = "room_changed_topic"
       case room_e2e_enabled = "room_e2e_enabled"
       case room_e2e_disabled = "room_e2e_disabled"
       case user_muted = "user-muted"
       case user_unmuted = "user-unmuted"
       case room_removed_read_only = "room-removed-read-only"
       case room_set_read_only = "room-set-read-only"
       case room_allowed_reacting = "room-allowed-reacting"
       case room_disallowed_reacting = "room-disallowed-reacting"
       case command = "command"
       case videoconf = "videoconf"
       case message_pinned = "message_pinned"
       case new_moderator = "new-moderator"
       case moderator_removed = "moderator-removed"
       case new_owner = "new-owner"
       case owner_removed = "owner-removed"
       case new_leader = "new-leader"
       case leader_removed = "leader-removed"
       case discussion_created = "discussion-created"
    }
    
    enum TeamMessagesType: String {
        case removed_user_from_team = "removed-user-from-team"
        case added_user_to_team = "added-user-to-team"
        case ult = "ult"
        case user_converted_to_team = "user-converted-to-team"
        case user_converted_to_channel = "user-converted-to-channel"
        case user_removed_room_from_team = "user-removed-room-from-team"
        case user_deleted_room_from_team = "user-deleted-room-from-team"
        case user_added_room_to_team = "user-added-room-to-team"
        case ujt = "ujt"
    }

    enum LivechatMessageType: String {
        case livechat_navigation_history = "livechat_navigation_history"
        case livechat_transfer_history = "livechat_transfer_history"
        case omlichannel_proirity_change_history = "omnichannel_priority_change_history"
        case omnichannel_sla_change_history = "omnichannel_sla_change_history"
        case livechat_transcript_history = "livechat_transcript_history"
        case livechat_video_call = "livechat_video_call"
        case livechat_transfer_history_fallback = "livechat_transfer_history_fallback"
        case livechat_close = "livechat-close"
        case livechat_webrtc_video_call = "livechat_webrtc_video_call"
        case livechat_started = "livechat-started"
    }

    enum VoipMessageType: String {
        case callStarted = "voip-call-started"
        case callDeclined = "voip-call-declined'"
        case callOnHold = "voip-call-on-hold"
        case callUnhold = "voip-call-unhold"
        case callEnded = "voip-call-ended"
        case callDuration = "voip-call-duration"
        case callWarpup = "voip-call-wrapup"
        case callEndedUnexpectedly = "voip-call-ended-unexpectedly"
    }
    
    enum MessageAttachment: String {
        case messageAttachmentAction = "MessageAttachmentAction"
        case messageAttachmentDefault = "MessageAttachmentDefault"
        case fileAttachmentProps = "FileAttachmentProps"
        case messageQuoteAttachment = "MessageQuoteAttachment"
    }
    
    struct MessageUrl {

        enum HeadersValue: String {
            case contentLenght
            case contentType
        }

        let url: String
        let source: String?
        let meta: [String: String]
        let headers: [[HeadersValue: String]]
    }
    
    

    let rid: String
    let msg: String
    let tmid: String?
    var tshow: Bool?
    let ts: Date
    var mentions: [MentionType]? //     ???
    var groupable: Bool?
    var channels: [String: String]
    let u: UserShort
    let blocks: MessageSurfaceLayout
    let alias: String?
    let md: String?
    var _hidden: Bool?
    var imported: Bool?
    let replies: [User]?
    let location: Location
    let starred: [String]?
    var pinned: Bool?
    let pinnedAt: Date?
    let pinnedBy: String?
    var unread: Bool?
    var temp: Bool?
    let drid: String?
    let tlm: Date?
    let dcount: Int?
    let tcount: Int?
    let t: MessageTypesValue?
    let e2e: E2e.StatusValue?
    let otrAck: String?
    let urls: [MessageUrl]?
    let files: [FileProp]?
    let attachments: [MessageAttachment]?
    let reactions: String? //              ???
    var `private`: Bool?
    var bot: Bool?
    var sentByEmail: Bool?
    let webRtcCallEndTs: Date?
    let role: String?
    let avatar: String?
    let emoji: String?
    let tokens: [String]?
    let token: String?
    let federation: Federation?
    let slaData: String //                  ???
    let priorityData: String? //            ???
    
    //    let actionLinks:
    //    let fileUpload:
}


struct Location {
    let type: String
    let coordinates: [Int: Int]
}

struct FileProp {
    let _id: String
    let name: String
    let type: String
    let format: String
    let size: Int
}
