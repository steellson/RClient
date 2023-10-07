//
//  AddServerView.swift
//  RClient
//
//  Created by Andrew Steellson on 07.10.2023.
//

import SwiftUI

struct AddServerView: View {
    
    @ObservedObject var viewModel: AddServerViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Image("rocketChatLogoLarge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 80)
                
                VStack(alignment: .leading) {
                    Text(
                        "Rocket.Chat server info:"
                    )
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    
                    TextField(
                        "Enter name of server",
                        text: $viewModel.serverUrl
                    )
                    .modifier(TextFieldModifier(strokeColor: .gray))
                    
                    TextField(
                        "http://",
                        text: $viewModel.serverUrl
                    )
                    .modifier(TextFieldModifier(strokeColor: .gray))
                    
                    Button("Add new one") {
                        
                    }
                    .modifier(RCButtonModifier(strokeColor: .gray))
                    .disabled(!viewModel.isValidUrl)
                }
                .padding(.horizontal, 30)
            }
            .padding()
            .frame(maxHeight: 600)
        }
    }
}

#Preview {
    AddServerView(viewModel: ViewModelFactoryInstance.makeAddServerViewModel())
}
