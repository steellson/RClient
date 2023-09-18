//
//  RClientFactory.swift
//  RClient
//
//  Created by Andrew Steellson on 23.08.2023.
//

import Foundation
import Moya


//MARK: - App dependencies

final class ApplicationFactory {
    
    fileprivate let apiProvider: MoyaProvider<RocketChatAPI>
    fileprivate let keyChainService: KeyChainService
    fileprivate let localStorageManager: LocalStorageManager
    fileprivate let userService: UserService
    fileprivate let validationService: ValidationService
    fileprivate let userDefaultsInstance: UserDefaults = UserDefaults.standard
    
    fileprivate let rClientViewModel: RClientAppViewModel
    fileprivate let authorizationViewModel: AuthorizationViewModel
    fileprivate let joinServerViewModel: JoinServerViewModel
    fileprivate let homeScreenViewModel: HomeViewModel
    
    init() {
        apiProvider = MoyaProvider<RocketChatAPI>()
        keyChainService = KeyChainService()
        localStorageManager = LocalStorageManager(
            userDefaultsInstance: userDefaultsInstance,
            keyChainService: keyChainService
        )
        userService = UserService(localStorageManager: localStorageManager)
        validationService = ValidationService()
        
        rClientViewModel = RClientAppViewModel(userService: userService)
        authorizationViewModel =  AuthorizationViewModel(
            validationService: validationService,
            moyaProvider: apiProvider,
            localStorageManager: localStorageManager
        )
        joinServerViewModel = JoinServerViewModel(
                                                localStorageManager: localStorageManager,
                                                validationService: validationService,
                                                moyaService: apiProvider
        )
        homeScreenViewModel = HomeViewModel()
        
        setupServerCreditionsContainer()
//        removeServerCreditionsContainer()
//        removeKeyChainRecord(forServer: "https://open.rocket.chat")
    }
}

//MARK: - App manage methods

private extension ApplicationFactory {
    
    func setupServerCreditionsContainer() {
        let container = [ServerCreditions]()
        
        if userDefaultsInstance.object(forKey: LocalStorageManager.UDKeys.serverCreditions.rawValue) != nil {
            print(R.SystemDebugError.serverCreditionsContainerExists.rawValue)
        } else {
            userDefaultsInstance.set(container, forKey: LocalStorageManager.UDKeys.serverCreditions.rawValue)
        }
    }
    
    func removeServerCreditionsContainer() {
        userDefaultsInstance.removeObject(forKey: LocalStorageManager.UDKeys.serverCreditions.rawValue)
    }
    
    func removeKeyChainRecord(forServer url: String) {
        do {
            try keyChainService.removeCreds(forServer: url)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


//MARK: - Screen builder

protocol ScreenFactoryProtocol: AnyObject {
    var rClientViewModel: RClientAppViewModel { get }
    
    func makeJoinServerScreen() -> JoinServerView
    func makeLoginScreen() -> LoginView
    func makeRegistrationScreenView() -> RegistrationView
    func makeHomeScreen() -> HomeView
}

final class ScreenFactory {
    
    fileprivate let applicationFactory = ApplicationFactory()
    fileprivate init() {}
}

extension ScreenFactory: ScreenFactoryProtocol {
    
    var rClientViewModel: RClientAppViewModel {
        applicationFactory.rClientViewModel
    }
    
    
    func makeJoinServerScreen() -> JoinServerView {
        JoinServerView(viewModel: applicationFactory.joinServerViewModel)
    }
    
    func makeLoginScreen() -> LoginView {
        LoginView(viewModel: applicationFactory.authorizationViewModel)
    }
    
    func makeRegistrationScreenView() -> RegistrationView {
        RegistrationView(viewModel: applicationFactory.authorizationViewModel)
    }


    func makeHomeScreen() -> HomeView {
        HomeView()
    }
}


//MARK: - Global Initialization

let screenFactory: ScreenFactoryProtocol = ScreenFactory()
