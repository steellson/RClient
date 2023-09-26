//
//  ServerIconView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI
import Kingfisher

struct ServerIconView: View {
    
    @State var image: KFImage
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 60, maxHeight: 60)
            .clipShape(Circle())
    }
}

struct ServerIconView_Previews: PreviewProvider {
    static var previews: some View {
        ServerIconView(
            image: KFImage(URL(string: "https://open.rocket.chat"))
        )
    }
}
