//
//  UpdateNameUserRequest.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UpdateNameUserRequest: APIRequest{
    
    typealias Response = UpdateNameUserResponse
    
    
    let name: String
    let username: String
        
    init(name: String,
         username: String) {
        self.name = name
        self.username = username
            
        }
        
    var method: Method {
        return .PUT
    }
        
    var path: String {
        return "/users/\(username)"
    }
        
    var parameters: [String : String] {
        return [:]
    }
        
    var body: [String : Any] {
        return ["name" : name]

    }
        
    var headers: [String : String] {
        return [:]
    }
    
}


