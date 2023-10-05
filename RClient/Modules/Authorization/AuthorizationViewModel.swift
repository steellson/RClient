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
    
    @Published var currentUrl: String = ""
    
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
    private let localStorageService: LocalStorageService
    private let navigationStateService: NavigationStateService
    
    private var anyCancellables: Set<AnyCancellable> = []
    
    init(
        validationService: ValidationService,
        moyaProvider: MoyaProvider<RocketChatAPI>,
        localStorageService: LocalStorageService,
        navigationStateService: NavigationStateService
    ) {
        self.validationService = validationService
        self.moyaProvider = moyaProvider
        self.localStorageService = localStorageService
        self.navigationStateService = navigationStateService
        
        validateLoginFields()
        validateRegistrationFields()
    }
    
    
    func signIn() {
        guard let currentUrl = localStorageService.getAllServerCreds().first?.url else {
            print("ERROR: Current url is not found"); return
        }
        login(
            with: UserLoginForm(user: loginEmailText,password: loginPasswordText),
            serverUrl: currentUrl
        )
        navigationStateService.globalState = .root
    }
    
    func signUp() {
        registration(with: UserRegistrationForm(
            email: registrationEmailText,
            pass: registrationPasswordText,
            username: usernameText,
            name: fullNameText
        ))
        navigationStateService.globalState = .login
    }

    private func login(with user: UserLoginForm, serverUrl: String) {
        moyaProvider.request(.login(user: user), completion: { [unowned self] result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        
                        // Save user info
                        self.localStorageService.save(userInfo: User(
                            id: loginResponse.data.userID,
                            services: loginResponse.data.me.services,
                            emails: loginResponse.data.me.emails,
                            roles: loginResponse.data.me.roles,
                            status: loginResponse.status,
                            active: loginResponse.data.me.active,
                            updatedAt: loginResponse.data.me.updatedAt,
                            name: loginResponse.data.me.name,
                            username: loginResponse.data.me.username,
                            statusConnection: loginResponse.data.me.statusConnection,
                            utcOffset: loginResponse.data.me.utcOffset,
                            email: loginResponse.data.me.email,
                            settings: loginResponse.data.me.settings,
                            avatarURL: loginResponse.data.me.avatarURL
                        ))
                        
                        // Save security token
                        DispatchQueue.global(qos: .background).async {
                            self.localStorageService.saveAccessToken(
                                forServer: serverUrl,
                                token: loginResponse.data.authToken
                            )
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
        .map { [unowned self] emailText, passwordText in
            (self.validationService.validate(emailText, method: .username)
             && self.validationService.validate(passwordText, method: .password))
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
