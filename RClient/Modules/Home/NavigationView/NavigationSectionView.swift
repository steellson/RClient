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
        VStack(alignment: .leading) {
            Text("Channels")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            
            Divider()
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.channels) { channel in
                        HStack {
                            Image(
                                systemName: channel.iconName ?? "bubble.left"
                            )
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)

                            Text(channel.name)
                                .font(.system(size: 18, weight: .regular))
                                .fontWeight(.regular)

                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 10)

                    }
                }
            }
        }
    }
}

struct NavigationSectionView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeNavigationSectionView()
    }
}
