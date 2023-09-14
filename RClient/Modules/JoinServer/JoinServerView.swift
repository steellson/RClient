//
//  JoinServerView.swift
//  RClient
//
//  Created by Andrew Steellson on 21.08.2023.
//

import SwiftUI

struct JoinServerView: View {
    
    @ObservedObject var viewModel: JoinServerViewModel
    
    private var strokeColor: Color {
        viewModel.isValidUrl ? .white : .rocketRed
    }
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .center) {
                Image("rocketChatLogoLarge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360, height: 100)
                
                VStack(alignment: .leading) {
                    Text(
                        R.Strings.joinServerFieldPreviewText.rawValue
                    )
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    
                    TextField(
                        R.Strings.rocketChatOpenServerUrl.rawValue,
                        text: $viewModel.serverUrl
                    )
                    .modifier(TextFieldModifier(strokeColor: strokeColor))
                    
                    Button("Connect") {
                        viewModel.setupServerCreditions()
                    }
                    .modifier(RCButtonModifier(strokeColor: strokeColor))
                    .disabled(!viewModel.isValidUrl)
                    .padding(.vertical)
                }
                .padding(.horizontal, 30)
            }
            .frame(maxHeight: 600)
        }
    }
}

struct JoinServerView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeJoinServerScreen()
    }
}
