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
    
    init() {
        apiProvider = MoyaProvider<RocketChatAPI>()
        urlManager = URLManager(userDefaultsInstance: userDefaultsInstance)
        userService = UserService(urlManager: urlManager)
        
        rClientViewModel = RClientAppViewModel(userService: userService)
        joinServerViewModel = JoinServerViewModel(urlManager: urlManager)
    }
}


//MARK: - Screen builder

protocol ScreenFactoryProtocol: AnyObject {
    var rClientViewModel: RClientAppViewModel { get }
    
    func makeJoinServerScreen() -> JoinServerView
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
    
    func makeHomeScreen() -> HomeView {
        HomeView()
    }
}


//MARK: - Initialization

let screenFactory: ScreenFactoryProtocol = ScreenFactory()