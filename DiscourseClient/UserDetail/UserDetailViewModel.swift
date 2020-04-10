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
                
                DispatchQueue.main.async {[weak self] in
                    self?.viewDelegate?.userDetailFetched()
                }
                
                break
            case .failure(_):
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
    
    func editButtonTapped() {guard let updateStatusURL = URL(string: "https://mdiscourse.keepcoding.io/t/\(userUsername).json") else { return }

                let configuration = URLSessionConfiguration.default
                let session = URLSession(configuration: configuration)
            
                var request = URLRequest(url: updateStatusURL)
                request.httpMethod = "PUT"
                request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
                request.addValue("aarcala10", forHTTPHeaderField: "Api-Username")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
                let body: [String: Any] = [
                    "name": "aarcala11",
                    
                ]
                guard let dataBody = try? JSONSerialization.data(withJSONObject: body) else { return }
                request.httpBody = dataBody
            
                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    if let response = response as? HTTPURLResponse {
                        print("\(response.statusCode)User Edited")
                            DispatchQueue.main.async {[weak self] in
                                self?.viewDelegate?.userEdited()
                            }
                        }
                        DispatchQueue.main.async { [weak self] in
                            print ("Error editing user...")
                            self?.viewDelegate?.userDetailErrorEditUser()
                    }
                    
                    
            }
                
                
            dataTask.resume()
    
    }
    
    
    
}
