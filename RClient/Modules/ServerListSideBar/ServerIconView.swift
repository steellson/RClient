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
        KFImage(URL(string: imageURL))
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 60, maxHeight: 60)
            .clipShape(Circle())
    }
}

#Preview {
    ServerIconView(imageURL: "https://open.rocket.chat")
}
