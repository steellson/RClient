//
//  NavigationRowView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.09.2023.
//

import SwiftUI

struct NavigationRowView: View {
    
    let channel: ChannelItem
    
    var body: some View {
        
        HStack {
            Image(
                systemName: channel.iconName ?? "bubble.left"
            )
            .resizable()
            .scaledToFill()
            .frame(width: 20, height: 20)
            
            Text(channel.name)
                .font(.system(size: 18, weight: .regular))
                .fontWeight(.regular)
            
            Spacer()
        }
        Divider()
    }
}

struct NavigationRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationRowView(channel: ChannelItem(id: "sd", name: "sdsdsd"))
    }
}
