//
//  Channel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.09.2023.
//

import Foundation
import Kingfisher

struct Channel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let image: KFImage?
}
