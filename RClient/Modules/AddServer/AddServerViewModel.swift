//
//  AddServerViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 07.10.2023.
//

import Foundation

final class AddServerViewModel: ObservableObject {
    
    @Published var serverUrl: String = ""
    @Published var isValidUrl: Bool = false
    
    private let localStorageService: LocalStorageService
    
    init(
        localStorageService: LocalStorageService
    ) {
        self.localStorageService = localStorageService
    }
}
