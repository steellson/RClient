//
//  RClientApp.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

@main
struct RClientApp: App {
        
    @ObservedObject private var viewModel = ViewModelFactoryInstance.makeRClientViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            RootView(viewModel: ViewModelFactoryInstance.makeRootViewModel())
        }
        .defaultPosition(.center)
        .defaultSize(width: 700, height: 400)
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified(showsTitle: false))
        .commands {
            CommandMenu("Channel") {
                Button("Add new channel") {
                    print("Should creating join server window")
                }
                .keyboardShortcut("n", modifiers: .command)
            }
        }

        
//        Window("JoinServer", id: "JoinServerView") {
//            JoinServerView(viewModel: ViewModelFactoryInstance.makeJoinServerViewModel())
//        }
//        
//        Window("Auth", id: "LoginView") {
//            LoginView(viewModel: ViewModelFactoryInstance.makeAuthorizationViewModel())
//        }
//        
//        Window("Root", id: "RootView") {
//            RootView(viewModel: ViewModelFactoryInstance.makeRootViewModel())
//        }
    }
}
