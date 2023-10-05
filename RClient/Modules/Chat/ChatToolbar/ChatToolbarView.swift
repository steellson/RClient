//
//  ChatToolbarView.swift
//  RClient
//
//  Created by Andrew Steellson on 05.10.2023.
//

import SwiftUI

struct ChatToolbarView: View {
    
    @ObservedObject var viewModel: ChatToolbarViewModel
    
    var body: some View {
        
        HStack {
            Image(systemName: "plus")
                .resizable()
                .clipped()
                .foregroundStyle(.gray)
                .frame(width: 18, height: 18)
            
            TextField(
                "Enter message ...",
                text: $viewModel.message
            )
            .modifier(TextFieldModifier(strokeColor: .gray))
            
            Image(systemName: "paperplane")
                .resizable()
                .clipped()
                .foregroundStyle(.gray)
                .frame(width: 18, height: 18)
        }
        .padding(10)
    }
}

#Preview {
    ChatToolbarView(viewModel: ViewModelFactoryInstance.makeChatToolbarViewModel())
}
