//
//  CategoriesCellViewModel.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 04/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class CategoriesCellViewModel {
    let categorie: CatDetail
    var textLabelText: String?
    
    
    
    init(categorie: CatDetail) {
        self.categorie = categorie
        
        textLabelText = categorie.name
        
    }
}
