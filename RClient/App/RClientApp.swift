//
//  RClientApp.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

@main
struct RClientApp: App {
    
    @ObservedObject var viewModel = RClientAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            if !viewModel.isClientOnboarded() {
                HomeView()
            } else {
                JoinServerView()
            }
        }
    }
}
