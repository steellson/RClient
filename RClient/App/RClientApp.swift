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
            RClientContentView(viewModel: viewModel)
        }
        
        // Styling
        .defaultPosition(.center)
        .defaultSize(width: 800, height: 400)
        .windowResizability(.contentSize)
        .windowToolbarStyle(.unified(showsTitle: false))
        
        // Shortcuts
        .commands {
            CommandMenu("Channel") {
                NavigationLink("Add new channel") {
                    LoginView(viewModel: ViewModelFactoryInstance.makeAuthorizationViewModel())
                }
                .keyboardShortcut("n", modifiers: .command)
            }
        }
        
        
        // Windows
        Window("Auth", id: "auth") {
            LoginView(viewModel: ViewModelFactoryInstance.makeAuthorizationViewModel())
        }
        .defaultSize(width: 300, height: 300)
        
        Window("Settings", id: "settings") {
            SettingsView(viewModel: ViewModelFactoryInstance.makeSettingsViewModel())
        }
        .defaultSize(width: 240, height: 400)
    }
}
