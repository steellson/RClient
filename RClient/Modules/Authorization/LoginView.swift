//
//  LoginView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.openWindow) var openWindow
    
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
                        
                        if viewModel.currentUrl != "" {
                            Text(
                                "For URL: \(viewModel.currentUrl)"
                            )
                            .font(.subheadline)
                            .fontWeight(.light)
                            .opacity(0.3)
                        }
                        
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
                            viewModel.isLoginAlertShowing.toggle()
                        }
                        .modifier(RCButtonModifier(strokeColor: strokeColor))
                        .disabled(!viewModel.isLoginFieldsValid)
                        .alert(
                            "Login successfull!",
                            isPresented: $viewModel.isLoginAlertShowing) {
                                Button("Tap to continue") {
                                    dismiss()
                                    openWindow.callAsFunction(id: "RootView")
                                }
                                .background(.clear)
                            } message: {
                                Text("Let's start it :)")
                            }
                        
                        
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
                        
                        NavigationLink {
                            screenFactory.makeJoinServerScreen()
                        } label: {
                            Text("Want to change server?")
                                .underline()
                                .font(.system(size: 12))
                                .fontWeight(.light)
                        }
                        .buttonStyle(.plain)
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
