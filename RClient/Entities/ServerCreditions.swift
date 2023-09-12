//
//  ServerCreditions.swift
//  RClient
//
//  Created by Andrew Steellson on 13.09.2023.
//

import Foundation


struct ServerCreditions: Codable {
    let url: String
    var token: String?
}

// Identity + Creds

typealias CreditionsStorage = [String: ServerCreditions?]
