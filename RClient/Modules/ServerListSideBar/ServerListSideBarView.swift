//
//  ServerListSideBarView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct ServerListSideBarView: View {
    
    @Environment(\.openWindow) var openWindow
    
    @ObservedObject var viewModel: ServerListSideBarViewModel
    
    var body: some View {
        VStack {
            LazyVStack {
                ScrollView {
                    ForEach(viewModel.servers) { server in
                        Button(action: {
                            viewModel.selectedServer = nil
                            viewModel.selectedServer = server
                        }, label: {
                            ServerIconView(imageURL: server.imageUrl)
                        })
                        .buttonStyle(.plain)
                    }
                }
            }
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom, content: {
            VStack {
                Button {
                    openWindow(id: "addServer")
                } label: {
                    Text("+")
                        .font(.system(size: 28))
                        .foregroundColor(.gray)
                }
                .modifier(ServerListToolbarButtonModifier())
                
                Button {
                    openWindow(id: "settings")
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
                .modifier(ServerListToolbarButtonModifier())
            }

        })
        .padding(.vertical, 10)
    }
}

#Preview {
    ServerListSideBarView(viewModel: ViewModelFactoryInstance.makeServerListSideBarViewModel())
}
