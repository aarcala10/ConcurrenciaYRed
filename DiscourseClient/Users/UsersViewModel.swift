//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

/// ViewModel que representa un listado de topics
class UsersViewModel {
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    let usersDataManager: UsersDataManager
    var userViewModels: [UserCellViewModel] = []

    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    func fetchUsersList() {
                userViewModels = []
        let period = "weekly"
        let order = "topic_count"
        
        DispatchQueue.main.async {[weak self] in
            
            self?.usersDataManager.fetchAllUsers(period: period, order: order) { result in
            switch result {
            case .success(let response):
                
                let responseArray = [response.userList]
                
                for item in responseArray {
                    for userObject in item {
                        self?.userViewModels.append(UserCellViewModel(users: userObject))
        
                    }
                }
                
//                print("\(self.userViewModels)")
                DispatchQueue.main.async {[weak self] in
                    self?.viewDelegate?.usersFetched()
                    
                }
                break
            case .failure(let error):
                print(error)
            }
            }
        }
        
    }
    func viewWasLoaded() {
        /** TODO:
         Recuperar el listado de latest topics del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos topics listos para pintar
         */
        fetchUsersList()
    }
        
    

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        return userViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: userViewModels[indexPath.row].users.user)
    }

}
