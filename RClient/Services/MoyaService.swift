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
    
}

extension RocketChatAPI: TargetType {
    
    public var serverUrl: String {
        guard let creds = UserDefaults.standard.object(forKey: URLManager.UDKeys.serverCreditions.rawValue) as? CreditionsStorage else {
            print("serverURL ERROR");return String()
        }
        return creds.first?.value?.url ?? "https://398b-94-180-63-98.ngrok-free.app"
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
    
    public var headers: [String : String]? {
        switch self {
        case .login: return [
            "Content-Type": "application/json"
//            "X-Auth-Token": "D_dv-vu7jM3TH8qIpqCEQMi_JL2w6l4QE8czJflcLLQ",
//            "X-User-Id": "2DGHszq2oqJAzm36X"
        ]
        }
    }
}
