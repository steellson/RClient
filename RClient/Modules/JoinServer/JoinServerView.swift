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
                    text: $viewModel.serverUrl
                )
                .textFieldStyle(.roundedBorder)
                .frame(width: 280)
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(strokeColor, lineWidth: 0.8)
                }
                
                NavigationLink("Connect") {
                    if viewModel.isTokenExists {
                        screenFactory.makeHomeScreen()
                    } else {
                        screenFactory.makeLoginScreen()
                    }
                }
                .disabled(!viewModel.isValidUrl)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.vertical, 4)
                .padding(.horizontal, 28)
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(strokeColor, lineWidth: 0.8)
                }
                .buttonStyle(.borderless)
                .padding(.vertical)
            }
            .padding(.horizontal, 30)
        }
    }
}

struct JoinServerView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeJoinServerScreen()
    }
}
