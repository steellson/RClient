//
//  ChatMessageView.swift
//  RClient
//
//  Created by Andrew Steellson on 25.09.2023.
//

import SwiftUI

struct ChatMessageView: View {
    
    let message: Message
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("\(message.u.username ?? "unnamed"):")
                .font(.title2)
                .fontDesign(.monospaced)
                .fontWeight(.bold)
            
            Text(message.msg)
                .font(.system(size: 20))
                .fontWeight(.medium)
            
            HStack {
                Spacer()
                                
                Text(timestampToTime(fromString: message.ts))
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
        }
        .padding()
        .cornerRadius(20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    //MARK: - Helpers
    
    func timestampToTime(fromString string: String) -> String {
        let fullTimeString = String(string.split(separator: "T")[1])
        let timeString = String(fullTimeString.split(separator: ".")[0])
        return timeString
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(message: Message(
            id: "id202",
            t: nil,
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
}
