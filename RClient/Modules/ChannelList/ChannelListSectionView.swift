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
                    .tag(
                        ChannelItem(
                            id: channel.id,
                            name: channel.name,
                            iconName: channel.iconName
                        )
                    )
                    .background(.clear)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .leading
                    )
                    .onTapGesture {
                        if viewModel.selectedChannel != channel {
                            viewModel.selectedChannel = nil
                            viewModel.selectedChannel = channel
                        }
                    }
            }
            .listStyle(.sidebar)
        }

    }
}

#Preview {
    ChannelSectionListView(viewModel: ViewModelFactoryInstance.makeChannelListSectionViewModel())
}
