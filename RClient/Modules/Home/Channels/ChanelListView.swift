//
//  ChanelListView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI
import Kingfisher

struct ChanelListView: View {
    
    @ObservedObject var viewModel: ChannelListViewModel
    
    var body: some View {
        VStack {
            LazyVStack {
                ScrollView {
                    ForEach(viewModel.channels) { channel in
                        ChanelCircleView(
                            image: channel.image ?? KFImage(
                                URL(string: "https://open.rocket.chat")
                            )
                        )
                        .shadow(color: .black, radius: 6, x: -5, y: 6)
                    }
                }
            }
            
            Spacer()
            
            Button {
                print("Add chanel")
            } label: {
                Text("+")
            }
            .buttonStyle(.borderless)
            .frame(maxWidth: 40, maxHeight: 40)
            .background(.quaternary)
            .clipShape(Circle())
        }
        .padding(.vertical, 10)
    }
}

struct ChanelListView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeChannelListView()
    }
}
