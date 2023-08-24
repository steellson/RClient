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
    
    private let urlManager: URLManager
    
    init(
        urlManager: URLManager
    ) {
        self.urlManager = urlManager
    }
    
    func joinServer() {
        
        // Make url persisted
        // TODO: - Regex checking url required
        urlManager.save(currentServerUrl: serverUrl)
        
        // Next login
    }
}
