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
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        ChatMessageView(message: message)
                            .frame(maxWidth: 260)
                            .background()
                    }
                }
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
            .background()
            
            HStack {
                ChatToolbarView(viewModel: ViewModelFactoryInstance.makeChatToolbarViewModel())
                
                Spacer()
            }
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
