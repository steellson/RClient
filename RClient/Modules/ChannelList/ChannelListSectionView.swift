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
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                    .onTapGesture {
                        viewModel.selectedChannel = nil
                        viewModel.selectedChannel = channel
                    }
            }
            .listStyle(.sidebar)
        }
    }
}

#Preview {
    ChannelSectionListView(viewModel: ViewModelFactoryInstance.makeChannelListSectionViewModel())
}
