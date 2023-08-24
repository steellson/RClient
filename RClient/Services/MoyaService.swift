//
//  MoyaService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

public enum RocketChatAPI {
    case login(user: Encodable)
    
}

extension RocketChatAPI: TargetType {
    
    public var serverUrl: String {
        let udInstance = UserDefaults.standard
        return (
            try? URLManager(
                userDefaultsInstance: udInstance
            ).getCurrentServerUrl()) ?? "https://open.rocket.chat/"
    }
    
    public var baseURL: URL { URL(string: "\(serverUrl)/api/v1")! }
    
    public var path: String {
        switch self {
        case .login: return "/login"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login: return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .login(let user): return .requestJSONEncodable(user)
        }
    }
    
//    public var sampleData: Data {
//        switch self {
//        case .login : return Data()
//        }
//    }
    
    public var headers: [String : String]? {
        switch self {
        case .login: return ["Content-Type": "application/json"]
        }
    }
    
}
