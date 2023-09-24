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
        VStack(alignment: .leading) {
            Text("CHAT #")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(10)
            
            LazyVStack {
                
            }
            
            Spacer()
        }
    }
}

struct ChatSectionView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeChatSectionView()
    }
}
