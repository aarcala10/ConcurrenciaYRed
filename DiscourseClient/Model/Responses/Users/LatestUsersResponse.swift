//
//  LatestUsersResponse.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct LatestUsersResponse: Codable {
    let userList: [Users]
    
    enum CodingKeys: String, CodingKey {
        case userList = "directory_items"
    }
}

struct Users : Codable {
    let user: User
}

struct User: Codable {
    let username: String
    let avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case avatarTemplate = "avatar_template"
    }
}
