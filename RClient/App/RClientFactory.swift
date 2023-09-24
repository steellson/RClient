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
    fileprivate let localStorageService: LocalStorageService
    fileprivate let userService: UserService
    fileprivate let validationService: ValidationService
    fileprivate let userDefaultsInstance: UserDefaults = UserDefaults.standard
    
    fileprivate let rClientViewModel: RClientAppViewModel
    fileprivate let authorizationViewModel: AuthorizationViewModel
    fileprivate let joinServerViewModel: JoinServerViewModel
    fileprivate let homeScreenViewModel: HomeViewModel
    fileprivate let serversSectionViewModel: ServersListViewModel
    fileprivate let navigationSectionViewModel: NavigationSectionViewModel
    fileprivate let chatSectionViewModel: ChatSectionViewModel
    fileprivate let detailSectionViewModel: DetailSectionViewModel
    
    init() {
        apiProvider = MoyaProvider<RocketChatAPI>()
        keyChainService = KeyChainService()
        localStorageService = LocalStorageService(
            userDefaultsInstance: userDefaultsInstance,
            keyChainService: keyChainService
        )
        userService = UserService(
            moyaProvider: apiProvider,
            localStorageService: localStorageService
        )
        validationService = ValidationService()
        
        rClientViewModel = RClientAppViewModel(
            userService: userService,
            localStorageService: localStorageService
        )
        authorizationViewModel =  AuthorizationViewModel(
            validationService: validationService,
            moyaProvider: apiProvider,
            localStorageService: localStorageService
        )
        joinServerViewModel = JoinServerViewModel(
                                                localStorageService: localStorageService,
                                                validationService: validationService,
                                                moyaService: apiProvider
        )
        homeScreenViewModel = HomeViewModel()
        serversSectionViewModel = ServersListViewModel(
            localStorageService: localStorageService
        )
        navigationSectionViewModel = NavigationSectionViewModel(
            localStorageService: localStorageService
        )
        chatSectionViewModel = ChatSectionViewModel()
        detailSectionViewModel = DetailSectionViewModel()
        
        
        // Config
        setupServerCreditionsContainer()
        setupUserInfoContainer()
        
        // Clear stored data
//        removeStoredContainers()
//        removeKeyChainRecord(
//            forServer: localStorageService
//                            .getAllServerCreds()
//                            .first?
//                            .url ?? "https://open.rocket.chat"
//        )
    }
}

//MARK: - Manage storage

private extension ApplicationFactory {
    
    func setupServerCreditionsContainer() {
        let container = [ServerCreditions]()
        
        if userDefaultsInstance.object(forKey: LocalStorageService.UDKeys.serverCreditions.rawValue) != nil {
            print(R.SystemDebugError.serverCreditionsContainerExists.rawValue)
        } else {
            userDefaultsInstance.set(container, forKey: LocalStorageService.UDKeys.serverCreditions.rawValue)
        }
    }
    
    func setupUserInfoContainer() {
        let container = [User]()
        
        if userDefaultsInstance.object(forKey: LocalStorageService.UDKeys.userInfo.rawValue) != nil {
            print(R.SystemDebugError.userInfoContainerExists.rawValue)
        } else {
            userDefaultsInstance.set(container, forKey: LocalStorageService.UDKeys.userInfo.rawValue)
        }
    }
    
    func removeStoredContainers() {
        userDefaultsInstance.removeObject(forKey: LocalStorageService.UDKeys.serverCreditions.rawValue)
        userDefaultsInstance.removeObject(forKey: LocalStorageService.UDKeys.userInfo.rawValue)
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
    
    func makeServersListView() -> ServersListView
    func makeNavigationSectionView() -> NavigationSectionView
    func makeChatSectionView() -> ChatSectionView
    func makeDetailSectionView() -> DetailSectionView
}

final class ScreenFactory {
    
    fileprivate let applicationFactory = ApplicationFactory()
    fileprivate init() {}
}

extension ScreenFactory: ScreenFactoryProtocol {
    
    var rClientViewModel: RClientAppViewModel {
        applicationFactory.rClientViewModel
    }
    
    // Main
    
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
        HomeView(viewModel: applicationFactory.homeScreenViewModel)
    }
    
    
    // Sub
    
    func makeServersListView() -> ServersListView {
        ServersListView(viewModel: applicationFactory.serversSectionViewModel)
    }
    
    func makeNavigationSectionView() -> NavigationSectionView {
        NavigationSectionView(viewModel: applicationFactory.navigationSectionViewModel)
    }
    
    func makeChatSectionView() -> ChatSectionView {
        ChatSectionView(viewModel: applicationFactory.chatSectionViewModel)
    }
    
    func makeDetailSectionView() -> DetailSectionView {
        DetailSectionView(viewModel: applicationFactory.detailSectionViewModel)
    }
}


//MARK: - Global Initialization

let screenFactory: ScreenFactoryProtocol = ScreenFactory()
