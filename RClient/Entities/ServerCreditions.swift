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


struct DataClass: Codable {
    let userID, authToken: String
    let me: User

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case authToken, me
    }
}
