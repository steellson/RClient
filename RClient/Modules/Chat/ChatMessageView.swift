//
//  ChatMessageView.swift
//  RClient
//
//  Created by Andrew Steellson on 25.09.2023.
//

import SwiftUI

struct ChatMessageView: View {
    
    let message: Message
    
    private var formatterdTimestamp: String {
        TimeStampFormatter
            .instance
            .timestampToTime(fromString: message.ts)
    }
    
    var isMyMessage: Bool = true
    
    var body: some View {
        
        VStack(alignment: isMyMessage
               ? .leading
               : .trailing,
               spacing: 10
        ) {
            Text("\(message.u.username ?? "unnamed"):")
                .font(.title3)
                .fontDesign(.monospaced)
                .fontWeight(.bold)
            
            Text(message.msg)
                .font(.system(size: 16))
                .fontWeight(.medium)
            
            HStack {
                Spacer()
                
                Text(formatterdTimestamp)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity)
            .padding([.bottom, .trailing], 4)
            
            
        }
        .padding(10)
        .background(Color(.darkGray))
        .cornerRadius(20)
        .frame(maxWidth: .infinity,
               alignment: isMyMessage
               ? .leading
               : .trailing
        )
    }
}

#Preview {
    ChatMessageView(message: Message(
        id: "id202",
//        t: nil,
        rid: Rid(),
        ts: "8T18:22:03",
        msg: "Hello",
        u: U(id: "id2222", username: "huevich"),
        groupable: nil,
        updatedAt: "22:22",
        urls: nil,
        mentions: nil,
        channels: nil,
        md: nil,
        tmid: nil,
        tshow: nil,
        replies: nil,
        tcount: nil,
        tlm: nil
    ))
}
