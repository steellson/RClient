//
//  ChannelSectionListView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct ChannelSectionListView: View {
    
    @ObservedObject var viewModel: ChannelSectionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Channels")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            
            Divider()
            
            List(viewModel.channels) { channel in
                ChannelRowView(channel: channel)
                    .background(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        if viewModel.selectedChat != channel {
                            viewModel.selectedChat = nil
                            viewModel.selectedChat = channel
                        }
                    }
            }
        }

    }
}

struct ChannelSectionListView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeChannelListSectionView()
    }
}
