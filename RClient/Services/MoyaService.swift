//
//  MoyaService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

enum RocketChatAPI{
    
    // Auth
    case login(user: UserLoginForm)
    case me(token: String)
    case signUp(form: UserRegistrationForm)
    
    // Channels
}

extension RocketChatAPI: TargetType {
    
    public var serverUrl: String {
        (
            UserDefaults.standard
            .object(forKey: LocalStorageService.UDKeys.serverCreditions.rawValue) as? [ServerCreditions]
        )?
            .first?
            .url ?? "https://open.rocket.chat"
    }
    
    public var baseURL: URL { URL(string: "\(serverUrl)/api/v1")! }
    
    public var path: String {
        switch self {
        case .login: return "/login"
        case .me: return "/me"
        case .signUp: return "/users.register"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .signUp: return .post
        case .me: return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .login(let user): return .requestJSONEncodable(user)
        case .me(let token): return .requestJSONEncodable(Me(resume: token))
        case .signUp(let form): return .requestJSONEncodable(form)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .login, .me: return [
            "Content-Type": "application/json"
            
        ]
        case .signUp: return [
            "Content-Type": "application/json"
        ]
        }
    }
}
