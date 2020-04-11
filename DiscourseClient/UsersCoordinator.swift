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
    let userDetailDataManager: UserDetailDataManager
    var usersViewModel: UsersViewModel?
    

    init(presenter: UINavigationController, usersDataManager: UsersDataManager, userDetailDataManager: UserDetailDataManager) {

        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }

    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        self.usersViewModel = usersViewModel
        presenter.pushViewController(usersViewController, animated: false)
    }

    override func finish() {}
}

extension UsersCoordinator: UsersCoordinatorDelegate {
    
    func didSelect(user: User) {
        let usersDetailViewModel = UserDetailViewModel(userUsername: user.username, userDetailDataManager: userDetailDataManager)
        let usersDetailViewController = UserDetailViewController(viewModel: usersDetailViewModel)
        usersDetailViewController.title = NSLocalizedString("User Details", comment: "")
        usersDetailViewModel.viewDelegate = usersDetailViewController
        usersDetailViewModel.coordinatorDelegate = self

        presenter.pushViewController(usersDetailViewController, animated: true)
    }

}


extension UsersCoordinator: UserDetailCoordinatorDelegate {
    func userDetailBackButtonTapped() {
        presenter.popViewController(animated: true)
        print("BACK")
    }
    
    

    func userDetailEditButtonTapped() {
//        presenter.ViewController(animated: true)
        
    }

}
