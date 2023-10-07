//
//  NavigationStateService.swift
//  RClient
//
//  Created by Andrew Steellson on 30.09.2023.
//

import Foundation
import SwiftUI
import Combine

enum GlobalState {
    case joinWelcomeServer
    case login
    case root
//    case addServer
    case settings
}

final class NavigationStateService: ObservableObject {
        
    @Published var globalState: GlobalState? = nil
        
}
