//
//  Settings.swift
//  RClient
//
//  Created by Andrew Steellson on 17.09.2023.
//

import Foundation

struct Settings: Codable {
    let profile: Profile
    let preferences: Preferences
}

struct Preferences: Codable {
    let hideRoles, hideFlexTab, enableAutoAway: Bool
    let desktopNotifications: String
    let unreadAlert, useEmojis, convertASCIIEmoji, autoImageLoad: Bool
    let saveMobileBandwidth, collapseMediaByDefault, hideUsernames: Bool
    let roomsListExhibitionMode: String
    let mergeChannels: Bool
    let sendOnEnter: String
    let viewMode: Int
    let emailNotificationMode, newRoomNotification, newMessageNotification: String
    let notificationsSoundVolume: Int
    let muteFocusedConversations, sidebarShowUnread, sidebarShowFavorites: Bool
    let sidebarViewMode: String
    let idleTimeLimit: Int
    let sidebarGroupByType, desktopNotificationRequireInteraction: Bool
    let sidebarSortby: String
    let desktopNotificationDuration: Int
    let displayAvatars, sidebarDisplayAvatar: Bool
    let pushNotifications, audioNotifications, mobileNotifications: String
    let hideAvatars, sidebarHideAvatar: Bool
    let alsoSendThreadToChannel: String
    let showMessageInMainThread, enableNewMessageTemplate, omnichannelTranscriptEmail: Bool
    let themeAppearence: String
    let showThreadsInMainChannel, notifyCalendarEvents, enableMobileRinging: Bool

    enum CodingKeys: String, CodingKey {
        case hideRoles, hideFlexTab, enableAutoAway, desktopNotifications, unreadAlert, useEmojis
        case convertASCIIEmoji = "convertAsciiEmoji"
        case autoImageLoad, saveMobileBandwidth, collapseMediaByDefault, hideUsernames, roomsListExhibitionMode, mergeChannels, sendOnEnter, viewMode, emailNotificationMode, newRoomNotification, newMessageNotification, notificationsSoundVolume, muteFocusedConversations, sidebarShowUnread, sidebarShowFavorites, sidebarViewMode, idleTimeLimit, sidebarGroupByType, desktopNotificationRequireInteraction, sidebarSortby, desktopNotificationDuration, displayAvatars, sidebarDisplayAvatar, pushNotifications, audioNotifications, mobileNotifications, hideAvatars, sidebarHideAvatar, alsoSendThreadToChannel, showMessageInMainThread, enableNewMessageTemplate, omnichannelTranscriptEmail, themeAppearence, showThreadsInMainChannel, notifyCalendarEvents, enableMobileRinging
    }
    
}
