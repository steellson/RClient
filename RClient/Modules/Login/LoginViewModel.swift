//
//  LoginViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya

final class LoginViewModel: ObservableObject {
    
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    private let moyaProvider: MoyaProvider<RocketChatAPI>
    
    init(
        moyaProvider: MoyaProvider<RocketChatAPI>
    ) {
        self.moyaProvider = moyaProvider
    }
    
    func login(with user: User) {
        moyaProvider.request(.login(user: user),
                             completion: { result in
            switch result {
            case .success(let response):
                print("Success!\n\(response.data)")
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
            }
        })
    }
}
