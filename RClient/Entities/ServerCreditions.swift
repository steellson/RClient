//
//  ServerCreditions.swift
//  RClient
//
//  Created by Andrew Steellson on 13.09.2023.
//

import Foundation


struct ServerCreditions: Codable, Stored {
    let url: String
    var nameOfServer: String?
}

