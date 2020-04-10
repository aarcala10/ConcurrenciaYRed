//
//  DiscourseClientDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


/// DataManager de la app. Usa un localDataManager y un remoteDataManager que colaboran entre ellos
/// En las extensiones de abajo, encontramos la implementación de aquellos métodos necesarios en cada módulo de la app
/// Este DataManager sólo utiliza llamadas remotas, pero podría extenderse para serialziar las respuestas, y poder implementar un offline first en el futuro
class DiscourseClientDataManager {
    let localDataManager: DiscourseClientLocalDataManager
    let remoteDataManager: DiscourseClientRemoteDataManager

    init(localDataManager: DiscourseClientLocalDataManager, remoteDataManager: DiscourseClientRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}
// MARK: TOPICS
extension DiscourseClientDataManager: TopicsDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(completion: completion)
    }
}

extension DiscourseClientDataManager: TopicDetailDataManager {
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }
}

extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, raw: String, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, raw: raw, completion: completion)
    }
}

// MARK: CATEGORIES

extension DiscourseClientDataManager: CategoriesDataManager {
    func fetchCategories(completion: @escaping (Result<LatestCategoriesResponse, Error>) -> ()) {
        remoteDataManager.fetchCategories(completion: completion)
    }
}

// MARK: USERS


extension DiscourseClientDataManager: UsersDataManager {
    
    func fetchAllUsers(period: String, order: String, completion: @escaping (Result<LatestUsersResponse, Error>) -> ()) {
        remoteDataManager.fetchAllUsers(period: period, order: order, completion: completion)
    }
}

extension DiscourseClientDataManager: UserDetailDataManager {
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse, Error>) -> ()) {
        remoteDataManager.fetchUser(username: username, completion: completion)
    }
}


