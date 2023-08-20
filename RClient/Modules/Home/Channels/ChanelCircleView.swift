//
//  ChanelCircleView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct ChanelCircleView: View {
    
    @State var image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
    }
}

struct ChannelCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ChanelCircleView(
            image: Image("arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
        )
    }
}
