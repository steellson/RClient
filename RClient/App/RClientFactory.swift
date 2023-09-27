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
    fileprivate let serverListSideBarViewModel: ServerListSideBarViewModel
    fileprivate let channelSectionViewModel: ChannelSectionViewModel
    fileprivate let chatSectionViewModel: ChatSectionViewModel
    fileprivate let detailSectionViewModel: DetailSectionViewModel
    
    fileprivate let rootViewModel: RootViewModel
    
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
        serverListSideBarViewModel = ServerListSideBarViewModel(
            localStorageService: localStorageService
        )
        channelSectionViewModel = ChannelSectionViewModel(
            userService: userService,
            localStorageService: localStorageService,
            moyaProvider: apiProvider
        )
        chatSectionViewModel = ChatSectionViewModel(
            localStorageService: localStorageService,
            moyaProvider: apiProvider,
            userService: userService
        )
        detailSectionViewModel = DetailSectionViewModel()
        rootViewModel = RootViewModel(
            serverListSideBarViewModel: serverListSideBarViewModel,
            channelListSectionViewModel: channelSectionViewModel,
            chatSectionViewModel: chatSectionViewModel
        )
        
        
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


//MARK: - ViewModel builder

protocol ViewModelFactoryProtocol: AnyObject {
    func makeRClientViewModel() -> RClientAppViewModel
    func makeRootViewModel() -> RootViewModel
    
    func makeJoinServerViewModel() -> JoinServerViewModel
    func makeAuthorizationViewModel() -> AuthorizationViewModel
    
    func makeServerListSideBarViewModel() -> ServerListSideBarViewModel
    func makeChannelListSectionViewModel() -> ChannelSectionViewModel
    func makeChatSectionViewModel() -> ChatSectionViewModel
    func makeDetailSectionViewModel() -> DetailSectionViewModel
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
    
    func makeRootViewModel() -> RootViewModel {
        applicationFactory.rootViewModel
    }
    
    // Join server
    func makeJoinServerViewModel() -> JoinServerViewModel {
        applicationFactory.joinServerViewModel
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
    
    // Detail
    func makeDetailSectionViewModel() -> DetailSectionViewModel {
        applicationFactory.detailSectionViewModel
    }
   
}


//MARK: - Global Initialization

let ViewModelFactoryInstance: ViewModelFactoryProtocol = ViewModelFactory()
