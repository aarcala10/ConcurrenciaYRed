//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 09/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


protocol UserDetailDataManager: class {
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse, Error>) -> ())
    func editUserName(name: String, username: String, completion: @escaping (Result<UpdateNameUserResponse, Error>) ->())
}
