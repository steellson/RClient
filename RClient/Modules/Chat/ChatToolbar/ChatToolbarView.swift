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
                R.Strings.chatTextFieldPlaceholder.rawValue,
                text: $viewModel.message
            )
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .autocorrectionDisabled()
                .lineSpacing(2)
                .padding(EdgeInsets(top: 1, leading: 6, bottom: 1, trailing: 6))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
            
            Image(systemName: "paperplane")
                .resizable()
                .clipped()
                .foregroundStyle(.gray)
                .frame(width: 18, height: 18)
            
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    ChatToolbarView(viewModel: ViewModelFactoryInstance.makeChatToolbarViewModel())
}
