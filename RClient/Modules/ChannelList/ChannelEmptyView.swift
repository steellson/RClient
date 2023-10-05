//
//  ChannelEmptyView.swift
//  RClient
//
//  Created by Andrew Steellson on 04.10.2023.
//

import SwiftUI

struct ChannelEmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "figure.fall")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.rocketRed)
                .frame(width: 80, height: 80)
                .clipped()
            
            Text("No picked channels yet ^_^")
                .font(.title2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ChannelEmptyView()
}
