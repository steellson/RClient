//
//  MoyaService.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

enum RocketChatAPI {
    case login(withCreditions: ServerCreditions)
    
}

extension RocketChatAPI: TargetType {
    
    public var serverUrl: String {
        let udInstance = UserDefaults.standard
        return (
            try? URLManager(userDefaultsInstance: udInstance)
                .getCurrentServerCreditions()?.url) ?? "https://open.rocket.chat/"
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
        case .login(let creditions): return .requestJSONEncodable(creditions)
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
