//
//  LoginViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine
import Moya

final class LoginViewModel: ObservableObject {
    
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    @Published private(set) var isFieldsValid: Bool = false
    
    private let moyaProvider: MoyaProvider<RocketChatAPI>
    
    private var anyCancellables: Set<AnyCancellable> = []
    
    init(
        moyaProvider: MoyaProvider<RocketChatAPI>
    ) {
        self.moyaProvider = moyaProvider
        
        validateFields()
    }
    
    func validateFields() {
        Publishers.CombineLatest($emailText, $passwordText)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { emailText, passwordText in
                !(emailText.isEmpty || passwordText.isEmpty)
            }
            .assign(to: \.isFieldsValid, on: self)
            .store(in: &anyCancellables)
    }
    
    func signIn() {
        login(with: User(user: emailText, password: passwordText))
    }
    
    private func login(with user: User) {
        moyaProvider.request(.login(user: user), completion: { result in
            switch result {
            case .success(let response):
                print("Success!\n\("RESOPONSE DATA:\(response.data),\nSTATUS: \(response.statusCode)")")
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
            }
        })
    }
}
