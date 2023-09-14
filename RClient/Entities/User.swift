//
//  User.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import Foundation

struct User: Codable {
    var user: String
    var password: String
}

struct UserForm: Codable {
    var username: String
    var name: String
    var email: String
    var pass: String
}
