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
        .defaultSize(width: 800, height: 400)
        .windowResizability(.contentSize)
        .windowToolbarStyle(.unified(showsTitle: false))
        .commands {
            CommandMenu("Channel") {
                Button("Add new channel") {
                    print("Should creating join server window")
                }
                .keyboardShortcut("n", modifiers: .command)
            }
        }
        
        Window("Add server", id: "addServer") {
            AddServerView(viewModel: ViewModelFactoryInstance.makeAddServerViewModel())
        }
        .defaultSize(width: 200, height: 100)
        
        Window("Settings", id: "settings") {
            SettingsView(viewModel: ViewModelFactoryInstance.makeSettingsViewModel())
        }
        .defaultSize(width: 240, height: 400)
    }
}
