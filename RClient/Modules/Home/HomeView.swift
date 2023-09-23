//
//  HomeView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    private let minHeight: CGFloat = 400
    
    var body: some View {
        HStack(spacing: 0) {
            
            // Channels section
            screenFactory.makeChannelListView()
                .background(.background)
                .frame(
                    minWidth: 80,
                    maxWidth: 80,
                    minHeight: minHeight,
                    maxHeight: .infinity
                )
            
            // Navigation section
            screenFactory.makeNavigationSectionView()
                .border(.gray, width: 0.4)
                .frame(
                    minWidth: 200,
                    maxWidth: .infinity,
                    minHeight: minHeight,
                    maxHeight: .infinity
                )
                 
            // Chat section
            screenFactory.makeChatSectionView()
                .border(.gray, width: 0.4)
                .frame(
                    minWidth: 400,
                    maxWidth: .infinity,
                    minHeight: minHeight,
                    maxHeight: .infinity
                )
              
            // Detail section
            screenFactory.makeDetailSectionView()
                .frame(
                    minWidth: 100,
                    maxWidth: .infinity,
                    minHeight: minHeight,
                    maxHeight: .infinity
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeHomeScreen()
    }
}
