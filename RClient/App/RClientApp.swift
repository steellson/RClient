//
//  RClientApp.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

@main
struct RClientApp: App {
        
    @ObservedObject var viewModel = screenFactory.rClientViewModel
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isClientOnboarded() {
                screenFactory.makeHomeScreen()
            } else {
                screenFactory.makeJoinServerScreen()
            }
        }
    }
}

