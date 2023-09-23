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
        Text("Chat section")
            .padding(5)

    }
}

struct ChatSectionView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeChatSectionView()
    }
}
