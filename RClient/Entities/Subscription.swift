//
//  Subscription.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import Foundation

struct Subscription {
    
    enum UnreadAlertType: String {
        case `default` = "default"
        case all
        case mentions
        case nothing
    }
    
    enum NotificationType: String {
        case all
        case mentions
        case nothing
    }
    
    let _id: String
    let u: UserShort
    let v: UserShort?
    let rid: String
    var open: Bool
    let ts: Date
    
    let name: String
    
    var alert: Bool?
    let unread: Int
    let t: Room.RoomType
    let ls: Date
    var f: Bool?
    let lr: Date
    var hireUnreadStatus: Bool? = true
    var hideMentionStatus: Bool? = true
    var teamMain: Bool?
    let teamId: String?
    
    let userMentions: Int
    let groupMentions: Int
    
    var broadcast: Bool? = true
    let tunread: [String]?
    let tunreadGroup: [String]?
    let runreadUser: [String]?
    
    let prid: String?
    
    var roles: [Role]?
    
    var onHold: Bool?
    var encrypted: Bool?
    let E2EKey: String?
    let E2ESuggestedKey: String?
    var unreadAlert: UnreadAlertType?
    
    let fname: String?
    
    var archived: Bool?
    let audioNotificationValue: String?
    let desktopNotifications: NotificationType?
    let mobilePushNotifications: NotificationType?
    let emailNotifications: NotificationType?
    let userHighlights: [String]?
    var autoTranslate: Bool?
    let autoTranstaleLanguage: String?
    var disableNotifications: Bool?
    var muteGroupMentions: Bool?
    let ignored: [User]?
    
    let desktopPrefOrigin: String
    let mobilePrefOrigin: String
    let emailPrefOrigin: String
    
    
//    let customFields:
    
}


struct Role {
    
    enum Scope: String {
        case users = "Users"
        case subscriptions = "Subscriptions"
    }
    
    let _id: String
    let name: String
    let description: String
    let mandatory2fa: Bool?
    let protected: Bool
    let scope: Scope
}
