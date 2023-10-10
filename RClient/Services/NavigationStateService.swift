//
//  NavigationStateService.swift
//  RClient
//
//  Created by Andrew Steellson on 30.09.2023.
//

import Foundation
import SwiftUI

enum GlobalState {
    case login
    case root
    case settings
}

enum SelectionState: Hashable {
    case selectedServer(ServerItem)
    case selectedChannel(Channel)
}

final class NavigationStateService: ObservableObject {
        
    @Published var globalState: GlobalState? = nil
    @Published var selectedServer: ServerItem? = nil
    @Published var selectedChannel: Channel? = nil
    
}
