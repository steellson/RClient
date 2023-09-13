//
//  LoginView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    private var strokeColor: Color {
        viewModel.isFieldsValid ? .white : .rocketRed
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
                                text: $viewModel.emailText
                            )
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 280)
                            .overlay {
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(strokeColor, lineWidth: 0.8)
                            }
                            
                            SecureField(
                                R.Strings.loginScreenPasswordFieldPlaceholder.rawValue,
                                text: $viewModel.passwordText
                            )
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 280)
                            .overlay {
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(strokeColor, lineWidth: 0.8)
                            }
                        }
                        .padding(.vertical)
                        
                        Button {
                            viewModel.signIn()
                        } label: {
                            Text("Login")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 28)
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(strokeColor, lineWidth: 0.8)
                        }
                        .disabled(!viewModel.isFieldsValid)
                        .buttonStyle(.borderless)
                         
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
