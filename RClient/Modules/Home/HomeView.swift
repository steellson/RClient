//
//  HomeView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        HStack {
            ChanelListView()
                .padding()
                .background(.background)
            
            Spacer()
            NavigationBarView()
                .frame(minWidth: 200)
                
            Spacer()
            
            ChatSectionView()
                .frame(minWidth: 200)
            Spacer()
            
            DetialBarView()
                .frame(maxWidth: 300)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
