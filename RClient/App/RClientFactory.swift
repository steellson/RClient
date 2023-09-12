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
    fileprivate let urlManager: URLManager
    fileprivate let userService: UserService
    fileprivate let userDefaultsInstance: UserDefaults = UserDefaults.standard
    
    fileprivate let rClientViewModel: RClientAppViewModel
    fileprivate let joinServerViewModel: JoinServerViewModel
    fileprivate let loginScreenViewModel: LoginViewModel
    fileprivate let registrationScreenViewModel: RegistrationViewModel
    fileprivate let homeScreenViewModel: HomeViewModel
    
    init() {
        apiProvider = MoyaProvider<RocketChatAPI>()
        urlManager = URLManager(userDefaultsInstance: userDefaultsInstance)
        userService = UserService(urlManager: urlManager)
        
        rClientViewModel = RClientAppViewModel(userService: userService)
        joinServerViewModel = JoinServerViewModel(urlManager: urlManager, moyaService: apiProvider)
        loginScreenViewModel =  LoginViewModel(moyaProvider: apiProvider)
        registrationScreenViewModel = RegistrationViewModel()
        homeScreenViewModel = HomeViewModel()
        
        setupServerCreditionsContainer()
        
//        userDefaultsInstance.removeObject(forKey: URLManager.UDKeys.serverCreditions.rawValue)
    }
    
    private func setupServerCreditionsContainer() {
        var container = CreditionsStorage()
        
        if userDefaultsInstance.object(forKey: URLManager.UDKeys.serverCreditions.rawValue) != nil {
            print(R.SystemDebugError.serverCreditionsContainerExists.rawValue)
        } else {
            container["initial"] = nil
            userDefaultsInstance.set(container, forKey: URLManager.UDKeys.serverCreditions.rawValue)
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
        LoginView(viewModel: applicationFactory.loginScreenViewModel)
    }
    
    func makeRegistrationScreenView() -> RegistrationView {
        RegistrationView(viewModel: applicationFactory.registrationScreenViewModel)
    }


    func makeHomeScreen() -> HomeView {
        HomeView()
    }
}


//MARK: - Global Initialization

let screenFactory: ScreenFactoryProtocol = ScreenFactory()
