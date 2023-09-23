//
//  HomeView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    private let minHeight: CGFloat = 600
    
    var body: some View {
        HStack {
            
            screenFactory.makeChannelListView()
                .background(.background)
                .frame(minWidth: 100, minHeight: minHeight)
                .onAppear {
                    let a = LocalStorageManager(
                            userDefaultsInstance: UserDefaults.standard,
                            keyChainService: nil
                    )
                    print("CHECK - - - - \(a.serverCreditions)")
                }
            
            Spacer()
            
            screenFactory.makeNavigationSectionView()
                .border(.gray, width: 0.4)
                .frame(minWidth: 140, minHeight: minHeight)
                
            Spacer()
            
            screenFactory.makeChatSectionView()
                .border(.gray, width: 0.4)
                .frame(minWidth: 240, minHeight: minHeight)
            
            Spacer()
            
            screenFactory.makeDetailSectionView()
                .frame(minWidth: 160, minHeight: minHeight)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeHomeScreen()
    }
}
