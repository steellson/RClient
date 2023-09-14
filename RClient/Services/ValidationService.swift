//
//  ValidationService.swift
//  RClient
//
//  Created by Andrew Steellson on 13.09.2023.
//

import Foundation

final class ValidationService {
    
    enum Methods: String {
        case urlString = "https://"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "[a-zA-Z0-9!@#$%^&*]+"
        case username = "^[a-zA-Z0-9]*$"
        case fullName = "^[a-zA-Z]+([_]?[a-zA-Z0-9])*$"
        
        case none
    }
    
    func validate(_ string: String, method: Methods) -> Bool {
        switch method {
        case .urlString:
            return string.starts(with: Methods.urlString.rawValue) && string.contains(".") && string.count >= 15
        case .email:
            return NSPredicate(format:"SELF MATCHES %@", Methods.email.rawValue).evaluate(with: string)
        case .password:
            return NSPredicate(format: "SELF MATCHES %@", Methods.password.rawValue).evaluate(with: string)
        case .username:
            return NSPredicate(format: "SELF MATCHES %@", Methods.username.rawValue).evaluate(with: string)
        case .fullName:
            return NSPredicate(format: "SELF MATCHES %@", Methods.fullName.rawValue).evaluate(with: string)
        case .none: return true
        }
    }
}
