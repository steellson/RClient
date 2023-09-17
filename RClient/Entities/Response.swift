//
//  Response.swift
//  RClient
//
//  Created by Andrew Steellson on 17.09.2023.
//

import Foundation

struct LoginResponse: Codable {
    let status: String
    let data: DataClass
}


struct RegistrationResponse: Codable {
    let user: ResponseUser
    let success: Bool
}

