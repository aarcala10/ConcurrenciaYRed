//
//  LatestCategoriesResponse.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 04/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct LatestCategoriesResponse: Codable {
    
    let categoriesList: Categories
    
    enum CodingKeys: String, CodingKey{
        case categoriesList = "category_list"
    }
}
struct Categories: Codable{
    let categories: [CatDetail]
}
struct CatDetail: Codable {
    let id: Int
    let name: String
}
