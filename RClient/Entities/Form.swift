//
//  Form.swift
//  RClient
//
//  Created by Andrew Steellson on 17.09.2023.
//

import Foundation

struct UserLoginForm: Codable {
    let user: String
    let password: String
}

struct UserRegistrationForm: Codable {
    var email: String
    var pass: String
    var username: String?
    var name: String?
}
