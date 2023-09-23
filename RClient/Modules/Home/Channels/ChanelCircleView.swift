//
//  ChanelCircleView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI
import Kingfisher

struct ChanelCircleView: View {
    
    @State var image: KFImage
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 60, maxHeight: 60)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.gray, lineWidth: 0.4)
            }
    }
}

struct ChannelCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ChanelCircleView(
            image: KFImage(URL(string: "https://open.rocket.chat"))
        )
    }
}
