//
//  HomeView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct HomeView: View {
    
    private let minHeight: CGFloat = 600
    
    var body: some View {
        HStack {
            ChanelListView()
                .background(.background)
                .frame(minWidth: 100, minHeight: minHeight)

            
            Spacer()
            NavigationView()
                .border(.gray, width: 0.4)
                .frame(minWidth: 140, minHeight: minHeight)
                
            Spacer()
            
            ChatSectionView()
                .border(.gray, width: 0.4)
                .frame(minWidth: 240, minHeight: minHeight)
            
            Spacer()
            
            DetialBarView()
                .frame(minWidth: 160, minHeight: minHeight)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
