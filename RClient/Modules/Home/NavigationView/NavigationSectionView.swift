//
//  NavigationSectionView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct NavigationSectionView: View {
    
    @ObservedObject var viewModel: NavigationSectionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Channels")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            
            Divider()
                .frame(height: 5)
            
            List(viewModel.channels) { channel in
                NavigationRowView(channel: channel)
                    .onTapGesture {
                        viewModel.selectedChat = channel
                    }
                    .background(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 10)
            }
        }
    }
}

struct NavigationSectionView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeNavigationSectionView()
    }
}
