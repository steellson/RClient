//
//  ChannelRowView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import SwiftUI

struct ChannelRowView: View {
    
    let channel: ChannelItem
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Image(
                    systemName: channel.iconName ?? "bubble.left"
                )
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .padding(8)
                
                VStack(alignment: .leading) {
                    Text(channel.name)
                        .font(.system(size: 18, weight: .regular))
                        .fontWeight(.regular)
                }
            }
            
            Divider()
        }
    }
}

#Preview {
    ChannelRowView(channel: ChannelItem(id: "sd", name: "sdsdsd"))
}
