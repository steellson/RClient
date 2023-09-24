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
    case loginWithToken(resume: String)
    case signUp(form: UserRegistrationForm)
    
    // Channels
    case getChannelList(token: String, userID: String)
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
        case .login, .loginWithToken: return "/login"
        case .signUp: return "/users.register"
            
        case .getChannelList: return "/channels.list"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .loginWithToken, .signUp: return .post
        case .getChannelList: return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .login(let user): return .requestJSONEncodable(user)
        case .loginWithToken(let token): return .requestJSONEncodable(token)
        case .signUp(let form): return .requestJSONEncodable(form)
            
        case .getChannelList: return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .login, .loginWithToken: return [
            "Content-Type": "application/json"
            
        ]

        case .signUp: return [
            "Content-Type": "application/json"
        ]
            
        case .getChannelList(let token, let userID): return [
            "X-Auth-Token": "\(token)",
            "X-User-Id": "\(userID)",
            "Content-Type": "application/json"
        ]
        }
    }
}
