//
//  LoginViewModel.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Combine

final class AuthorizationViewModel: ObservableObject {
    
    @Published var currentServer: ServerItem? = nil
    @Published var currentUser: User? = nil
    
    // Alerts
    @Published var isLoginAlertShowing: Bool = false
    @Published var isRegistrationAlertShowing: Bool = false
    
    // Login
    @Published var serverUrl: String = ""
    @Published var loginEmailText: String = ""
    @Published var loginPasswordText: String = ""
    
    // Reg
    @Published var usernameText: String = ""
    @Published var fullNameText: String = ""
    @Published var registrationEmailText: String = ""
    @Published var registrationPasswordText: String = ""
    @Published var replyPasswordText: String = ""
    
    // Valid
    @Published private(set) var isValidUrl: Bool = false
    @Published private(set) var isLoginFieldsValid: Bool = false
    @Published private(set) var isRegistrationFieldsValid: Bool = false
    
    // Services
    private let apiService: APIService
    private let validationService: ValidationService
    private let localStorageService: LocalStorageService
    private let navigationStateService: NavigationStateService
    
    private var anyCancellables: Set<AnyCancellable> = []
    
    init(
        apiService: APIService,
        localStorageService: LocalStorageService,
        navigationStateService: NavigationStateService,
        validationService: ValidationService
    ) {
        self.apiService = apiService
        self.localStorageService = localStorageService
        self.navigationStateService = navigationStateService
        self.validationService = validationService
        
        validateInputUrl()
        validateLoginFields()
        validateRegistrationFields()
    }
    
    func login() {
        apiService.login(with: UserLoginForm(
                                    user: loginEmailText,
                                    password: loginPasswordText,
                                    resume: nil
                            ), serverUrl: serverUrl
        ) { [unowned self] result in
            switch result {
            case .success(let loginResponse):
                let user = User(
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
                )
                let server = ServerItem(
                    id: UUID().uuidString,
                    name: nil,
                    url: serverUrl
                )
                self.currentUser = user
                self.currentServer = server
                
                // Save
                self.localStorageService.save(userInfo: user)
                self.localStorageService.save(serverItem: server)
                self.localStorageService.saveAccessToken(
                        forServer: self.serverUrl,
                        token: loginResponse.data.authToken
                    )
                
                self.navigationStateService.globalState = .root
                
                print("User \(user.email) sucsessfully loggined!")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func signUp() {
        apiService.registration(with: UserRegistrationForm(
            email: registrationEmailText,
            pass: registrationPasswordText,
            username: usernameText,
            name: fullNameText
        )) { [weak self] result in
            switch result {
            case .success(let regResponse):
                print(regResponse)
                self?.navigationStateService.globalState = .login
            case .failure(let error):
                print(error)
            }
        }
    }
}


//MARK: - Subscriptions

private extension AuthorizationViewModel {
    func validateInputUrl() {
        $serverUrl
            .dropFirst()
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .map { [unowned self] urlString in
                self.validationService.validate(urlString, method: .urlString)
            }
            .assign(to: \.isValidUrl, on: self)
            .store(in: &anyCancellables)
    }
    
    func validateLoginFields() {
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
    
    func validateRegistrationFields() {
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
