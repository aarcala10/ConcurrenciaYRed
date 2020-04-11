//
//  DiscourseClientRemoteDataManagerImpl.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación por defecto del protocolo remoto, en este caso usando SessionAPI
class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
        
    let session: SessionAPI

    init(session: SessionAPI) {
        self.session = session
    }

    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func addTopic(title: String, raw: String, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchCategories(completion: @escaping (Result<LatestCategoriesResponse, Error>) -> ()) {
        let request = LatestCategoriesRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchAllUsers(period: String, order: String, completion: @escaping (Result<LatestUsersResponse, Error>) -> ()) {
        let request = LatestUsersRequest(period: period, order: order)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse, Error>) -> ()) {
        let request = SingleUserRequest(username: username)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func editUserName(name: String, username: String, completion: @escaping (Result<UpdateNameUserResponse, Error>) -> ()) {
        let request = UpdateNameUserRequest(name: name, username: username)
        session.send(request: request) { result in
            completion(result)
        }
    }
        
}
