//
//  JoinServerViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

final class JoinServerViewModel: ObservableObject {
    
    @Published var serverUrl: String = ""
    
    private let udManager = URLManager()
    
    func joinServer() {
        
        // Make url persisted
        // TODO: - Regex checking url required
        udManager.save(currentServerUrl: serverUrl)
        
        // Next login
    }
}
