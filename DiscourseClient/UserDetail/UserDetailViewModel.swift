//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 09/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailCoordinatorDelegate: class {
    func userDetailBackButtonTapped()
    
}

protocol UserDetailViewDelegate: class {
    func userDetailFetched()
    func errorFetchingUserDetail()
    func userDetailErrorEditUser()
    func userEdited()
}

class UserDetailViewModel{
    var labelUserIDText: String?
    var labelUserUsernameText: String?
    var labelUserNameText: String?
    var modeUserEdit: Bool?
    

    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    
    var userUsername: String
    

    init(userUsername: String, userDetailDataManager: UserDetailDataManager) {
        self.userUsername = userUsername
        self.userDetailDataManager = userDetailDataManager
        
    }
    
    func fetchUserSingle() {
        
        userDetailDataManager.fetchUser (username: userUsername) { result in
            switch result {
            case .success(let response):
                
                self.labelUserNameText = response.user.name
                self.labelUserIDText = "\(response.user.id)"
                self.labelUserUsernameText = response.user.username
                
                self.modeUserEdit = response.user.canEditName
                    
                print ("Details user LOADED")

                /*
                 Este main.async tampoco haría falta puesto que todos los closures que se llaman
                 desde SessionAPI se llaman dentro de main.async, por tanto lo estaríamos haciendo
                 dos veces
                 */
                DispatchQueue.main.async {[weak self] in
                    self?.viewDelegate?.userDetailFetched()
                }
                
                break
            case .failure(_):
                /*
                 Este main.async tampoco haría falta puesto que todos los closures que se llaman
                 desde SessionAPI se llaman dentro de main.async, por tanto lo estaríamos haciendo
                 dos veces
                 */
                DispatchQueue.main.async {[weak self] in
                    self?.viewDelegate?.errorFetchingUserDetail()
                }
            }
        }
    }
    
    
    
    
    func viewDidLoad() {
        fetchUserSingle()
        
    }

    func backButtonTapped() {
        
        coordinatorDelegate?.userDetailBackButtonTapped()
        
    }
    
    func updateButtonTapped(name: String, username: String){

        userDetailDataManager.editUserName(name: name, username: username) { result in
        switch result {
            case .success(_):
                /*
                 Este main.async tampoco haría falta puesto que todos los closures que se llaman
                 desde SessionAPI se llaman dentro de main.async, por tanto lo estaríamos haciendo
                 dos veces
                 */
            DispatchQueue.main.async {[weak self] in
                self?.viewDelegate?.userEdited()
                print("Edited")
            }
            
            case .failure(_):
                /*
                 Este main.async tampoco haría falta puesto que todos los closures que se llaman
                 desde SessionAPI se llaman dentro de main.async, por tanto lo estaríamos haciendo
                 dos veces
                 */
                DispatchQueue.main.async {[weak self] in
                    self?.viewDelegate?.userDetailErrorEditUser()
                    print("Error Editing")
                }
                
            }
            
        }
                            
    }

}
                    
               
