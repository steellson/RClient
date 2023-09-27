//
//  ServerItem.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation
import Kingfisher

struct ServerItem: Identifiable, Hashable {
    
    let id: String = UUID().uuidString
    let name: String
    let image: KFImage
    
    static func == (lhs: ServerItem, rhs: ServerItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
