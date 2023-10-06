//
//  ChannelRowView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import SwiftUI

struct ChannelRowView: View {
    
    let channel: Channel
    
    private var formatterdTimestamp: String {
        guard let ts = channel.lastMessage?.ts else {
            return ""
        }
        return TimeStampFormatter.instance.timestampToTime(fromString: ts)
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(channel.name)
                .font(.system(size: 18, weight: .regular))
                .fontWeight(.regular)
            
            Text(channel.lastMessage?.msg ?? "No messages yet...")
                .font(.callout)
                .fontWeight(.thin)
            
            Text(formatterdTimestamp)
                .font(.callout)
                .fontWeight(.ultraLight)
            
            Divider()
        }
    }
}

#Preview {
    ChannelRowView(channel: Channel(
        id: "s",
        fname: "channel",
        customFields: nil,
        description: nil,
        broadcast: nil,
        encrypted: nil,
        name: "Channel",
        t: "t",
        msgs: 10,
        usersCount: 2,
        u: nil,
        ts: "22:22",
        ro: true,
        channelDefault: false,
        sysMes: nil,
        updatedAt: "23:22",
        lm: "",
        announcement: "",
        muted: nil,
        teamID: nil,
        teamDefault: nil,
        reactWhenReadOnly: nil,
        lastMessage: LastMessage(
            id: "2",
            t: nil,
            msg: "last message text",
            groupable: nil,
            blocks: nil,
            ts: "23:23",
            u: UElement(
                id: "2",
                name: "huy",
                username: "huyvuch",
                type: nil),
            rid: "",
            updatedAt: "",
            urls: [],
            mentions: [],
            channels: [],
            md: nil,
            tmid: nil,
            tshow: nil),
        usernames: nil, 
        topic: nil,
        jitsiTimeout: nil,
        joinCodeRequired: nil,
        streamingOptions: nil,
        announcementDetails: nil,
        archived: nil,
        unmuted: nil,
        featured: nil
    ))
}
