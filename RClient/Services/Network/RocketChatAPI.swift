//
//  RocketChatAPI.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

enum RocketChatAPI {
    
    // Auth
    case login(user: UserLoginForm)
    case loginWithToken(user: UserLoginForm)
    case signUp(form: UserRegistrationForm)
    
    // Channels
    case getJoinedChannelsList(token: String, userID: String)
    case getChannelMessages(MessageCreditions)
}

extension RocketChatAPI: TargetType {
    
    static var serverUrl: String = "http://localhost:3000"
    
    public var baseURL: URL {
        URL(string: "\(RocketChatAPI.serverUrl)/api/v1")!
    }
    
    public var path: String {
        switch self {
        case .login, .loginWithToken: return "/login"
        case .signUp: return "/users.register"
            
        case .getJoinedChannelsList: return "/channels.list.joined"
        case .getChannelMessages: return "/channels.messages"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .loginWithToken, .signUp: return .post
        case .getJoinedChannelsList, .getChannelMessages: return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .login(let user): return .requestJSONEncodable(user)
        case .loginWithToken(let user): return .requestJSONEncodable(user)
        case .signUp(let form): return .requestJSONEncodable(form)
            
        case .getJoinedChannelsList: return .requestPlain
        case .getChannelMessages(let creds): return .requestParameters(parameters: ["roomId": creds.roomId], encoding: URLEncoding.default)
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
            
        case .getJoinedChannelsList(let token, let userID): return [
            "X-Auth-Token": "\(token)",
            "X-User-Id": "\(userID)",
            "Content-Type": "application/json"
        ]
            
        case .getChannelMessages(let creds): return [
            "X-Auth-Token": "\(creds.token)",
            "X-User-Id": "\(creds.userID)",
            "Content-Type": "application/json"
        ]
        }
    }
}


//MARK: - Methods

extension RocketChatAPI {
    
}
