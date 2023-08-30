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
            if viewModel.isUserOnboarded {
                screenFactory.makeHomeScreen()
            } else {
                screenFactory.makeLoginScreen()
            }
        }
    }
}
