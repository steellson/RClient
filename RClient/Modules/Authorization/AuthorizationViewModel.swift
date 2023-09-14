//
//  LoginViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine
import Moya

final class AuthorizationViewModel: ObservableObject {
    
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    @Published private(set) var isFieldsValid: Bool = false
    
    private let moyaProvider: MoyaProvider<RocketChatAPI>
    private let validationService: ValidationService
    
    private var anyCancellables: Set<AnyCancellable> = []
    
    init(
        validationService: ValidationService,
        moyaProvider: MoyaProvider<RocketChatAPI>
    ) {
        self.validationService = validationService
        self.moyaProvider = moyaProvider
        
        validateFields()
    }
    
    func validateFields() {
        Publishers.CombineLatest($emailText, $passwordText)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { [validationService] emailText, passwordText in
                (validationService.validate(emailText, method: .email)
                 && validationService.validate(passwordText, method: .password))
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
                do {
                    let responseJSON = try response.mapJSON(failsOnEmptyData: true)
                    print("Success!\n\("RESOPONSE DATA:\(responseJSON),\nSTATUS: \(response.statusCode)")")
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
            }
        })
    }
}
