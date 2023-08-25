//
//  LoginView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Image("rocketLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .padding()
            
            Spacer()
            
            HStack {
                
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text(R.Strings.loginScreenWelcomeTitle.rawValue)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text(R.Strings.loginScreenSubtitle.rawValue)
                        .font(.title3)
                        .fontWeight(.regular)
                    
                    VStack {
                        TextField(
                            R.Strings.loginScreenEmailFieldPlaceholder.rawValue,
                            text: $viewModel.emailText
                        )
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 280)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.white, lineWidth: 0.5)
                        }
                        
                        SecureField(
                            R.Strings.loginScreenPasswordFieldPlaceholder.rawValue,
                            text: $viewModel.passwordText
                        )
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 280)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.white, lineWidth: 0.5)
                        }
                    }
                    .padding(.vertical)
                    
                    Button {
                        print("Login...")
                    } label: {
                        Text("Login")
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
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(.vertical, 50)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeLoginScreen()
    }
}
