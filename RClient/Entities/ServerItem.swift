//
//  ServerItem.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation
import Kingfisher

struct ServerItem: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let image: KFImage
}
