//
//  APIService.swift
//  RClient
//
//  Created by Andrew Steellson on 08.10.2023.
//

import Foundation
import Moya

final class APIService: ObservableObject {
    
    private let apiProvider: MoyaProvider<RocketChatAPI>
    
    var serverURL: String? {
        didSet {
            guard let serverURL = serverURL else { return }
            setupRocketChatAPI(with: serverURL)
        }
    }
    
    init(
        apiProvider: MoyaProvider<RocketChatAPI>
    ) {
        self.apiProvider = apiProvider
    }
    
    private func setupRocketChatAPI(with serverURL: String) {
        RocketChatAPI.serverUrl = serverURL
    }
}

//MARK: - Auth

extension APIService {
    
    func login(with 
               user: UserLoginForm,
               serverUrl: String,
               completion: @escaping (Result<LoginResponse, MoyaError>
               ) -> Void) {
        
        setupRocketChatAPI(with: serverUrl)
        apiProvider.request(.login(user: user), completion: { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        completion(.success(loginResponse))
                    } catch let error {
                        print(error.localizedDescription)
                        completion(.failure(MoyaError.encodableMapping(error)))
                    }
                } else {
                    completion(.failure(.statusCode(response)))
                }
                
            case .failure(let error):
                print("Failure: \(error)")
                completion(.failure(error))
            }
        })
    }
    
    func loginWithToken(_
                        prevToken: String,
                        serverUrl: String,
                        completion: @escaping (Result<User, MoyaError>) -> Void
    ) {
        
        let loginForm = UserLoginForm(user: nil, password: nil, resume: prevToken)
        
        setupRocketChatAPI(with: serverUrl)
        apiProvider.request(.loginWithToken(user: loginForm)) { result in
            switch result {
            case .success(let response):
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
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

                    // Send user
                    if response.statusCode == 200 {
                        completion(.success(user))
                    }
                } catch let error {
                    print("Cant fetch and send user: \(error)")
                    completion(.failure(.requestMapping(error.localizedDescription)))
                }
            case .failure(let error):
                print("ERROR: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func registration(with 
                      form: UserRegistrationForm,
                      completion: @escaping (Result<RegistrationResponse, MoyaError>
                      ) -> Void) {

        apiProvider.request(.signUp(form: form), completion: { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let signUpResponse = try JSONDecoder().decode(RegistrationResponse.self, from: response.data)
                        print(signUpResponse.user)
                        completion(.success(signUpResponse))
                    } catch let error {
                        print(error)
                        completion(.failure(.encodableMapping(error)))
                    }
                } else {
                    completion(.failure(.statusCode(response)))
                }
            case .failure(let error):
                print("Failure: \(error)")
                completion(.failure(error))
            }
        })
    }
}

//MARK: - Fetching

extension APIService {
    
    func fetchChannels(forServer 
                       url: String,
                       currentUserId: String,
                       token: String,
                       completion: @escaping (Result<ChannelsResponse, MoyaError>) -> Void
    ) {
        setupRocketChatAPI(with: url)
        apiProvider.request(.getJoinedChannelsList(token: token, userID: currentUserId), completion: { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let channelList = try JSONDecoder().decode(ChannelsResponse.self, from: response.data)
                        guard !channelList.channels.isEmpty else {
                            print("NavigationSection: Fetched channels is empty!")
                            completion(.failure(.requestMapping("Channels is empty")))
                            return
                        }
                        completion(.success(channelList))
                    } catch let error {
                        print("Cant decode channels: \(error)")
                        completion(.failure(.encodableMapping(error)))
                    }
                } else {
                    print("Fetching user status code: \(response.statusCode)")
                }
            case .failure(let error):
                print("Fetching user error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        })
    }
    
    func fetchChatMessages(with 
                           creditions: MessageCreditions,
                           completion: @escaping (Result<MessagesResponse, MoyaError>) -> Void
    ) {

        apiProvider.request(.getChannelMessages(creditions)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let messages = try JSONDecoder().decode(MessagesResponse.self, from: response.data)
                        guard !messages.messages.isEmpty else {
                            print("ChatSection: Fetched messages is empty!")
                            completion(.failure(.requestMapping("Messages is empty")))
                            return
                        }
                        completion(.success(messages))
                    } catch let error {
                        print("Cant decode messages: \(error)")
                        completion(.failure(.encodableMapping(error)))
                    }
                } else {
                    print("Fetching messages status code: \(response.statusCode)")
                }
            case .failure(let error):
                print("Fetching messages error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
