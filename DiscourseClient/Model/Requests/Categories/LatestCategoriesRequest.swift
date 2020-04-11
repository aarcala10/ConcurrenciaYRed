//
//  LatestCategoriesRequest.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 04/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct LatestCategoriesRequest: APIRequest {
    
    typealias Response = LatestCategoriesResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
