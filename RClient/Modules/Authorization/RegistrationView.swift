//
//  RegistrationView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AuthorizationViewModel
    
    private var strokeColor: Color {
        viewModel.isFieldsValid ? .white : .rocketRed
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            Image("rocketChatLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 60)
                .padding(.vertical, 18)
            
                Text(R.Strings.registrationTitleLabelText.rawValue)
                    .font(.title3)
                    .fontWeight(.regular)
                    .padding(.vertical, 8)
            
            VStack(spacing: 18) {
                TextField(
                    R.Strings.registrationScreenUsernameFieldPlaceholder.rawValue,
                    text: $viewModel.emailText
                )
                .modifier(TextFieldModifier(strokeColor: strokeColor))
                
                TextField(
                    R.Strings.registrationScreenFullNameFieldPlaceholder.rawValue,
                    text: $viewModel.emailText
                )
                .modifier(TextFieldModifier(strokeColor: strokeColor))
                
                TextField(
                    R.Strings.registrationScreenEmailFieldPlaceholder.rawValue,
                    text: $viewModel.emailText
                )
                .modifier(TextFieldModifier(strokeColor: strokeColor))
                
                SecureField(
                    R.Strings.registrationScreenPasswordFieldPlaceholder.rawValue,
                    text: $viewModel.emailText
                )
                .modifier(TextFieldModifier(strokeColor: strokeColor))
                
                SecureField(
                    R.Strings.registrationScreenReplyFieldPlaceholder.rawValue,
                    text: $viewModel.passwordText
                )
                .modifier(TextFieldModifier(strokeColor: strokeColor))
                
                Button("Sign Up") {
                    
                }
                .modifier(RCButtonModifier(strokeColor: strokeColor))
                .disabled(!viewModel.isFieldsValid)
                .padding(.vertical)
            }
            .padding(.bottom)
            
            Button {
                dismiss()
            } label: {
                Text("Go back!")
                    .underline()
                    .font(.system(size: 12))
                    .fontWeight(.light)
            }
            .buttonStyle(.plain)
            .padding(.top)
        }
        .padding(30)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeRegistrationScreenView()
    }
}
