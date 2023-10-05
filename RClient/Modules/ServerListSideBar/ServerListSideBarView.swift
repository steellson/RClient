//
//  ServerListSideBarView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct ServerListSideBarView: View {
    
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
                            ServerIconView(image: server.image)
                        })
                        .tag(server)
                        .buttonStyle(.plain)
                    }
                }
            }
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom, content: {
            Button {
                print("Add chanel")
            } label: {
                Text("+")
                    .font(.system(size: 28))
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(.borderless)
            .frame(maxWidth: 60, maxHeight: 60)
            .background(.quaternary)
            .clipShape(Circle())
            .shadow(
                color: .black.opacity(0.5),
                radius: 0.8,
                x: -2,
                y: 2
            )
        })
        .padding(.vertical, 10)
    }
}

#Preview {
    ServerListSideBarView(viewModel: ViewModelFactoryInstance.makeServerListSideBarViewModel())
}
