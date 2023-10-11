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
    
    fileprivate let apiService: APIService
    fileprivate let navigationStateService: NavigationStateService
    fileprivate let keyChainService: KeyChainService
    fileprivate let localStorageService: LocalStorageService
    fileprivate let userService: UserService
    fileprivate let validationService: ValidationService
    fileprivate let userDefaultsInstance: UserDefaults = UserDefaults.standard
    
    fileprivate let rClientViewModel: RClientAppViewModel
    fileprivate let authorizationViewModel: AuthorizationViewModel
    fileprivate let serverListSideBarViewModel: ServerListSideBarViewModel
    fileprivate let channelSectionViewModel: ChannelSectionViewModel
    fileprivate let chatSectionViewModel: ChatSectionViewModel
    fileprivate let chatToolbarViewModel: ChatToolbarViewModel
    fileprivate let detailSectionViewModel: DetailSectionViewModel
    fileprivate let settingsViewModel: SettingsViewModel
    
    
    init() {
        
        // Services
        apiProvider = MoyaProvider<RocketChatAPI>()
        apiService = APIService(apiProvider: apiProvider)
        navigationStateService = NavigationStateService()
        keyChainService = KeyChainService()
        localStorageService = LocalStorageService(
            userDefaultsInstance: userDefaultsInstance,
            keyChainService: keyChainService
        )
        userService = UserService(
            apiService: apiService,
            localStorageService: localStorageService
        )
        validationService = ValidationService()
        
        
        // ViewModels
        rClientViewModel = RClientAppViewModel(
            userService: userService,
            navigationStateService: navigationStateService
        )
        authorizationViewModel = AuthorizationViewModel(
            apiService: apiService,
            localStorageService: localStorageService,
            navigationStateService: navigationStateService,
            validationService: validationService
        )
        serverListSideBarViewModel = ServerListSideBarViewModel(
            localStorageService: localStorageService,
            navigationStateService: navigationStateService
        )
        channelSectionViewModel = ChannelSectionViewModel(
            apiService: apiService,
            localStorageService: localStorageService,
            userService: userService,
            navigationStateService: navigationStateService
        )
        chatSectionViewModel = ChatSectionViewModel(
            apiService: apiService,
            localStorageService: localStorageService,
            navigationStateService: navigationStateService,
            userService: userService
        )
        chatToolbarViewModel = ChatToolbarViewModel(
            apiService: apiService,
            navigationStateService: navigationStateService,
            localStorageService: localStorageService,
            userService: userService
        )
        detailSectionViewModel = DetailSectionViewModel()
        settingsViewModel = SettingsViewModel()
        

        // Clear stored data
//        removeStoredContainers()
//        localStorageService.getAllServerItems().forEach { removeKeyChainRecord(forServer: $0.url) }
//        removeKeyChainRecord(forServer: "https://open.rocket.chat")
//        removeKeyChainRecord(forServer: "http://192.168.0.104:3000")
    }
}

//MARK: - Manage storage

private extension ApplicationFactory {
    
    func removeStoredContainers() {
        userDefaultsInstance.removeObject(forKey: LocalStorageService.UDKeys.serverItems.rawValue)
        userDefaultsInstance.removeObject(forKey: LocalStorageService.UDKeys.userInfo.rawValue)
    }
    
    func removeKeyChainRecord(forServer url: String) {
        do {
            try keyChainService.removeCreds(forServer: url)
        } catch let error {
            print("ERROR: Cant remove keychain record \(error.localizedDescription)")
        }
    }
}


//MARK: - ViewModel builder

protocol ViewModelFactoryProtocol: AnyObject {
    func makeRClientViewModel() -> RClientAppViewModel

    func makeAuthorizationViewModel() -> AuthorizationViewModel
    func makeServerListSideBarViewModel() -> ServerListSideBarViewModel
    func makeChannelListSectionViewModel() -> ChannelSectionViewModel
    func makeChatSectionViewModel() -> ChatSectionViewModel
    func makeChatToolbarViewModel() -> ChatToolbarViewModel
    func makeDetailSectionViewModel() -> DetailSectionViewModel
    
    func makeSettingsViewModel() -> SettingsViewModel
}

final class ViewModelFactory {
    
    fileprivate let applicationFactory = ApplicationFactory()
    fileprivate init() {}
}

extension ViewModelFactory: ViewModelFactoryProtocol {
    
    // Root
    func makeRClientViewModel() -> RClientAppViewModel {
        applicationFactory.rClientViewModel
    }
    
    // Authorization
    func makeAuthorizationViewModel() -> AuthorizationViewModel {
        applicationFactory.authorizationViewModel
    }
    
    // Sections
    func makeServerListSideBarViewModel() -> ServerListSideBarViewModel {
        applicationFactory.serverListSideBarViewModel
    }
    
    func makeChannelListSectionViewModel() -> ChannelSectionViewModel {
        applicationFactory.channelSectionViewModel
    }
    
    func makeChatSectionViewModel() -> ChatSectionViewModel {
        applicationFactory.chatSectionViewModel
    }
    
    func makeChatToolbarViewModel() -> ChatToolbarViewModel {
        applicationFactory.chatToolbarViewModel
    }
    
    
    // Detail
    func makeDetailSectionViewModel() -> DetailSectionViewModel {
        applicationFactory.detailSectionViewModel
    }
    
    // Settings
    func makeSettingsViewModel() -> SettingsViewModel {
        applicationFactory.settingsViewModel
    }
}


//MARK: - Global Initialization

let ViewModelFactoryInstance: ViewModelFactoryProtocol = ViewModelFactory()
