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
    
    @Published var loginEmailText: String = ""
    @Published var loginPasswordText: String = ""
    
    @Published var usernameText: String = ""
    @Published var fullNameText: String = ""
    @Published var registrationEmailText: String = ""
    @Published var registrationPasswordText: String = ""
    @Published var replyPasswordText: String = ""
    
    @Published private(set) var isLoginFieldsValid: Bool = false
    @Published private(set) var isRegistrationFieldsValid: Bool = false
    
    private let moyaProvider: MoyaProvider<RocketChatAPI>
    private let validationService: ValidationService
    
    private var anyCancellables: Set<AnyCancellable> = []
    
    init(
        validationService: ValidationService,
        moyaProvider: MoyaProvider<RocketChatAPI>
    ) {
        self.validationService = validationService
        self.moyaProvider = moyaProvider
        
        validateLoginFields()
        validateRegistrationFields()
    }
    
    
    func signIn() {
        login(with: User(user: loginEmailText, password: loginPasswordText))
    }
    
    func signUp() {
        registration(with: UserForm(
            username: usernameText,
            name: fullNameText,
            email: registrationEmailText,
            pass: registrationPasswordText
        ))
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
    
    private func registration(with form: UserForm) {
        moyaProvider.request(.signUp(form: form), completion: { result in
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


//MARK: - Subscriptions

private extension AuthorizationViewModel {
    
    private func validateLoginFields() {
        Publishers.CombineLatest(
            $loginEmailText,
            $loginPasswordText
        )
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { [validationService] emailText, passwordText in
                (validationService.validate(emailText, method: .email)
                 && validationService.validate(passwordText, method: .password))
            }
            .assign(to: \.isLoginFieldsValid, on: self)
            .store(in: &anyCancellables)
    }
    
    private func validateRegistrationFields() {
        Publishers.CombineLatest4(
            $usernameText,
            $fullNameText,
            $registrationEmailText,
            $registrationPasswordText
        )
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { [unowned self] usernameText, fullNameText, emailText, passwordText in
                (
                    self.validationService.validate(usernameText, method: .username)
                    && self.validationService.validate(fullNameText, method: .fullName)
                    && self.validationService.validate(emailText, method: .email)
                    && self.validationService.validate(passwordText, method: .password)
                ) && passwordText == self.registrationPasswordText
            }
            .assign(to: \.isRegistrationFieldsValid, on: self)
            .store(in: &anyCancellables)
    }
}
