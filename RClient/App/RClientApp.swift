//
//  RClientApp.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

@main
struct RClientApp: App {
        
    @ObservedObject private var viewModel = screenFactory.rClientViewModel
    
    var body: some Scene {
        
        WindowGroup {
            if !viewModel.isUserOnboarded {
                screenFactory.makeJoinServerScreen()
            } else if !viewModel.isUserAuthorized {
                screenFactory.makeLoginScreen()
            } else {
                screenFactory.makeRootView()
            }
        }
        .defaultPosition(.center)
        .defaultSize(width: 600, height: 300)
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified(showsTitle: false))
        .commands {
            CommandMenu("Channel") {
                Button("Add new channel") {

                }
                .keyboardShortcut("n", modifiers: .command)
            }
        }
        
        Window("JoinServer", id: "JoinServerView") {
            screenFactory.makeJoinServerScreen()
        }
        
        Window("Auth", id: "LoginView") {
            screenFactory.makeLoginScreen()
        }
        
        Window("Root", id: "RootView") {
            screenFactory.makeRootView()
        }
    }
}
