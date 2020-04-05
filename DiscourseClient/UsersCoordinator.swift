//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
//    let userDetailDataManager: UserDetailDataManager
    var usersViewModel: UsersViewModel?
    

    init(presenter: UINavigationController, usersDataManager: UsersDataManager) {

        self.presenter = presenter
        self.usersDataManager = usersDataManager
//        self.userDetailDataManager = userDetailDataManager
    }

    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.viewDelegate = usersViewController
//        usersViewModel.coordinatorDelegate = self
        self.usersViewModel = usersViewModel
        presenter.pushViewController(usersViewController, animated: false)
    }

    override func finish() {}
}

//extension UsersCoordinator: UsersCoordinatorDelegate {
//    func didSelect(user: Users) {
//        /** TODO: Lanzar módulo TopicDetail
//         Para ello tendrás que crear TopicDetailViewModel, TopicDetailViewController.
//         Asignar "self" como coordinatorDelegate del módulo: Queremos escuchar eventos que requieren navegación desde ese módulo.
//         Asignar el VC al viewDelegate del VM. De esta forma, el VC se enterará de lo necesario para pintar la UI
//         Finalmente, lanzar el TopicDetailViewController sobre el presenter.
//         */
//        let usersDetailViewModel = UserDetailViewModel(topicID: topic.id, userDetailDataManager: userDetailDataManager)
//        let usersDetailViewController = UserDetailViewController(viewModel: usersDetailViewModel)
//        usersDetailViewController.title = NSLocalizedString("User Details", comment: "")
//        usersDetailViewModel.viewDelegate = topicsDetailViewController
//        usersDetailViewModel.coordinatorDelegate = self
//
//        presenter.pushViewController(usersDetailViewController, animated: true)
//    }
//
//}


//extension UsersCoordinator: UserDetailCoordinatorDelegate {
//
//    func userDetailDelButtonTapped() {
//        presenter.popViewController(animated: true)
//        usersViewModel?.viewWasLoaded()
//    }
//
//}
