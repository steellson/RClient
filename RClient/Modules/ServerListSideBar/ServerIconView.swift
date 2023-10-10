//
//  ServerIconView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI
import Kingfisher

struct ServerIconView: View {
    
    let imageURL: String
    
    var body: some View {
        if URL(string: imageURL) != nil {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 60, maxHeight: 60)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.2.circle")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 60, maxHeight: 60)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ServerIconView(imageURL: "https://open.rocket.chat")
}
