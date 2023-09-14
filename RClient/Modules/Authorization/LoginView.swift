//
//  LoginView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: AuthorizationViewModel
    
    private var strokeColor: Color {
        viewModel.isLoginFieldsValid ? .white : .rocketRed
    }
    
    var body: some View {
        
        NavigationStack {
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
                            .foregroundColor(.white)
                        
                        Text(R.Strings.loginScreenSubtitle.rawValue)
                            .font(.title3)
                            .fontWeight(.regular)
                        
                        VStack {
                            TextField(
                                R.Strings.loginScreenEmailFieldPlaceholder.rawValue,
                                text: $viewModel.loginEmailText
                            )
                            .modifier(TextFieldModifier(strokeColor: strokeColor))

                            
                            SecureField(
                                R.Strings.loginScreenPasswordFieldPlaceholder.rawValue,
                                text: $viewModel.loginPasswordText
                            )
                            .modifier(TextFieldModifier(strokeColor: strokeColor))
                        }
                        .padding(.vertical)
                        
                        Button("Login") {
                            viewModel.signIn()
                        }
                        .modifier(RCButtonModifier(strokeColor: strokeColor))
                        .disabled(!viewModel.isLoginFieldsValid)
                         
                        Spacer()
                        
                        NavigationLink {
                            screenFactory.makeRegistrationScreenView()
                        } label: {
                            Text("Need registration?")
                                .underline()
                                .font(.system(size: 12))
                                .fontWeight(.light)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 30)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
        }
        .padding(.vertical, 50)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeLoginScreen()
    }
}
