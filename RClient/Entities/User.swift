//
//  User.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import Foundation

struct User {
    
    let user: String
    let password: String
    var resume: String?
    
}

extension User: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case user
        case password
        case token = "resume"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(user, forKey: .user)
        try container.encode(password, forKey: .password)
        try container.encode(resume, forKey: .token)
    }
}


//MARK: - Server Creditions

struct ServerCreditions: Encodable {
    let url: String
    var token: String?
}
