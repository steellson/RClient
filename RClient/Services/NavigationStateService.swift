//
//  NavigationStateService.swift
//  RClient
//
//  Created by Andrew Steellson on 30.09.2023.
//

import Foundation
import Combine

enum GlobalState {
    case joinServer
    case login
    case root
    case settings
}

final class NavigationStateService: ObservableObject {
    
    @Published var globalState: GlobalState? = nil
        

    func goToSettings() {
        
    }
}
