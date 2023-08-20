//
//  ChanelListView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct ChanelListView: View {
    var body: some View {
        VStack {
            ChanelCircleView(image: Image("galaxy"))
            ChanelCircleView(image: Image("galaxy"))
            ChanelCircleView(image: Image("galaxy"))
            ChanelCircleView(image: Image("galaxy"))
            ChanelCircleView(image: Image("galaxy"))
            Spacer()
            Button {
                print("Add chanel")
            } label: {
                Text("+")
            }
            .buttonStyle(.borderless)
            .frame(width: 100, height: 100)
            .background(.quaternary)
            .clipShape(Circle())
        }
        .padding(10)
    }
}

struct ChanelListView_Previews: PreviewProvider {
    static var previews: some View {
        ChanelListView()
    }
}
