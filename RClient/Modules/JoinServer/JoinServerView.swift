//
//  JoinServerView.swift
//  RClient
//
//  Created by Andrew Steellson on 21.08.2023.
//

import SwiftUI

struct JoinServerView: View {
    
    @State private var textFieldText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("rocketChatLogoLarge")
                .resizable()
                .scaledToFit()
                .frame(width: 360, height: 100)
            
            Text(
                R.Strings.joinServerFieldPreviewText.rawValue
            )
            .foregroundColor(.white)
            .font(.title2)
            .fontWeight(.semibold)
                            
            TextField(
                R.Strings.rocketChatOpenServerUrl.rawValue,
                text: $textFieldText
            )
            .textFieldStyle(.roundedBorder)
            .frame(width: 280)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.white, lineWidth: 0.5)
            }
            
            Button {
                print("Connect...")
            } label: {
                Text("Connect")
                    .font(.callout)
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 28)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.white, lineWidth: 0.5)
            }
            .buttonStyle(.borderless)
            .padding(.vertical)
        }
        .padding(.horizontal, 30)
    }
}

struct JoinServerView_Previews: PreviewProvider {
    static var previews: some View {
        JoinServerView()
    }
}
