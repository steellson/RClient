//
//  RootView.swift
//  RClient
//
//  Created by Andrew Steellson on 26.09.2023.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var viewModel: RootViewModel
        
    var body: some View {
        
        NavigationSplitView {
            screenFactory.makeServerListSideBarView()
                .navigationSplitViewColumnWidth(86)
            
        } content: {
            screenFactory.makeChannelListSectionView()
                .frame(minWidth: 260, minHeight: 320)
            
        } detail: {
            screenFactory.makeChatSectionView()
                .frame(minWidth: 380, minHeight: 320)

        }

    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeRootView()
    }
}
