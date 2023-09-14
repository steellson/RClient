//
//  MoyaService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

enum RocketChatAPI {
    case login(user: User)
    case signUp(form: UserForm)
    
}

extension RocketChatAPI: TargetType {
    
    public var serverUrl: String {
        let udInstance = UserDefaults.standard
        return URLManager(userDefaultsInstance: udInstance)
            .getAllServerCreds()
            .first?
            .url ?? "https://open.rocket.chat"
    }
    
    public var baseURL: URL { URL(string: "\(serverUrl)/api/v1")! }
    
    public var path: String {
        switch self {
        case .login: return "/login"
        case .signUp: return "/users.register"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .signUp: return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .login(let user): return .requestJSONEncodable(user)
        case .signUp(let form): return .requestJSONEncodable(form)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .login: return [
            "Content-Type": "application/json"
            
        ]
        case .signUp: return [
            "Content-Type": "application/json"
        ]
        }
    }
}
