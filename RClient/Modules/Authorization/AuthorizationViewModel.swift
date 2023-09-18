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
    
    @Published var isLoginAlertShowing: Bool = false
    @Published var isRegistrationAlertShowing: Bool = false
    
    @Published var usernameText: String = ""
    @Published var fullNameText: String = ""
    @Published var registrationEmailText: String = ""
    @Published var registrationPasswordText: String = ""
    @Published var replyPasswordText: String = ""
    
    @Published private(set) var isLoginFieldsValid: Bool = false
    @Published private(set) var isRegistrationFieldsValid: Bool = false
    
    private let moyaProvider: MoyaProvider<RocketChatAPI>
    private let validationService: ValidationService
    private let localStorageManager: LocalStorageManager
    
    private var anyCancellables: Set<AnyCancellable> = []
    
    init(
        validationService: ValidationService,
        moyaProvider: MoyaProvider<RocketChatAPI>,
        localStorageManager: LocalStorageManager
    ) {
        self.validationService = validationService
        self.moyaProvider = moyaProvider
        self.localStorageManager = localStorageManager
        
        validateLoginFields()
        validateRegistrationFields()
    }
    
    
    func signIn() {
        guard let lastCreditions = localStorageManager.getAllServerCreds().first else {
            print("ERROR: Current url is not found"); return
        }
        login(
            with: UserLoginForm(user: loginEmailText, password: loginPasswordText),
            serverUrl: lastCreditions.url
        )
    }
    
    func signUp() {
        registration(with: UserRegistrationForm(
            email: registrationEmailText,
            pass: registrationPasswordText,
            username: usernameText,
            name: fullNameText
        ))
    }
    
    private func login(with user: UserLoginForm, serverUrl: String) {
        moyaProvider.request(.login(user: user), completion: { [unowned self] result in
            switch result {
            case .success(let response):
                
                if response.statusCode == 200 {
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        
                        DispatchQueue.global(qos: .background).async {
                            self.localStorageManager.saveAccessToken(forServer: serverUrl, token: loginResponse.data.authToken)
                        }
                        print(loginResponse.data.authToken)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                } else {
                    print("ERROR! Check status code: \(response.statusCode)")
                }
                
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
            }
        })
    }
    
    private func registration(with form: UserRegistrationForm) {
        moyaProvider.request(.signUp(form: form), completion: { result in
            switch result {
            case .success(let response):
                
                if response.statusCode == 200 {
                    do {
                        let signUpResponse = try JSONDecoder().decode(RegistrationResponse.self, from: response.data)
                        print(signUpResponse.user)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                } else {
                    print("ERROR! Check status code: \(response.statusCode)")
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
            (validationService.validate(emailText, method: .username)
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
            ) && self.replyPasswordText == self.registrationPasswordText
        }
        .assign(to: \.isRegistrationFieldsValid, on: self)
        .store(in: &anyCancellables)
    }
}
