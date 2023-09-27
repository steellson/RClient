//
//  ServerIconView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI
import Kingfisher

struct ServerIconView: View {
    
    let image: KFImage
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 60, maxHeight: 60)
            .clipShape(Circle())
    }
}

#Preview {
    ServerIconView(
        image: KFImage(URL(string: "https://open.rocket.chat"))
    )
}
