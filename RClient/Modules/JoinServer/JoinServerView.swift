//
//  JoinServerView.swift
//  RClient
//
//  Created by Andrew Steellson on 21.08.2023.
//

import SwiftUI

struct JoinServerView: View {
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismiss) var dismiss
    
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
                        viewModel.saveServerItem()
                        viewModel.alertIsPresented.toggle()
                    }
                    .modifier(RCButtonModifier(strokeColor: strokeColor))
                    .disabled(!viewModel.isValidUrl)
                    .alert(
                        "Server added!",
                        isPresented: $viewModel.alertIsPresented) {
                            Button("Go authorize!") {
                                dismiss()
                                openWindow(id: "LoginView")
                            }
                        } message: {
                            Text("You could change it later")
                        }
                        .padding(.vertical)
                }
                .padding(.horizontal, 30)
            }
            .padding()
            .frame(maxHeight: 600)
        }
    }
}

#Preview {
    JoinServerView(viewModel: ViewModelFactoryInstance.makeJoinServerViewModel())
}
