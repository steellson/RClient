//
//  ChatSectionView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct ChatSectionView: View {
    
    @ObservedObject var viewModel: ChatSectionViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("CHAT #")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                
                Spacer()
            }
            
            Divider()
            
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        if viewModel.isMyMessageCheck(message: message) {
                            HStack {
                                ChatMessageView(message: message)
                                    .frame(maxWidth: 260)
                                    .background()
                                Spacer()
                            }
                        } else {
                            HStack {
                                Spacer()
                                ChatMessageView(message: message)
                                    .frame(maxWidth: 260)
                                    .background()
                            }
                            
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
            .background()
            
            ChatToolbarView(viewModel: ViewModelFactoryInstance.makeChatToolbarViewModel())
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "rectangle.righthalf.inset.filled")
                })
            }
        }
        //        .inspector(isPresented: $viewModel.isInspectorHidden) {
        //            Group {
        //            }
        //        }
    }
}

#Preview {
    ChatSectionView(viewModel: ViewModelFactoryInstance.makeChatSectionViewModel())
}
