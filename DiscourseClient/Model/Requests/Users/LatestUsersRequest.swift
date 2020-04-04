//
//  LatestUsersRequest.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct LatestUsersRequest: APIRequest {
    
    typealias Response = LatestUsersResponse
    
    let period: String
    let order: String
    
    init(period: String,
         order: String) {
        self.period = period
        self.order = order
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/directory_items.json"
    }
    
    var parameters: [String : String] {
        return ["period": period,
                "order": order]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
