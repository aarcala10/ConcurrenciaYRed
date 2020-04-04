//
//  CategoriesDataManager.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 04/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesDataManager: class {
    func fetchCategories(completion: @escaping (Result<LatestCategoriesResponse, Error>) -> ())

}
