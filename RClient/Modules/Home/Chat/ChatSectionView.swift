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
            Text("CHAT #")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            Divider()
            
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        ChatMessageView(message: message)
                            .frame(maxWidth: 260)
                            .background()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background()
            
        }
        .padding(10)
    }
}

struct ChatSectionView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeChatSectionView()
    }
}
