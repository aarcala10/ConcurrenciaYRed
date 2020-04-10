//
//  SingleUserResponse.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 09/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct SingleUserResponse: Codable {
    let user: UserDetail
   
}
struct UserDetail: Codable {

    let id: Int
    let username: String
    let name: String?
    let canEditName: Bool
    
    enum CodingKeys: String, CodingKey{
        
        case id
        case username
        case name
        case canEditName = "can_edit_name"
    }
}
