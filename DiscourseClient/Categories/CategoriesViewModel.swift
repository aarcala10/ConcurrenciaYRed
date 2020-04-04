//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel representando un listado de categorías

protocol CategoriesViewDelegate: class {
    func categoriesFetched()
    func errorFetchingCategories()

}

class CategoriesViewModel {
    weak var viewDelegate: CategoriesViewDelegate?
    let categoriesDataManager: CategoriesDataManager
    var categorieViewModels: [CategoriesCellViewModel] = []
    
    
    init(categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
    }
    
    func fetchCategorieList() {
                categorieViewModels = []
                categoriesDataManager.fetchCategories { result in
            switch result {
            case .success(let response):
                
                let responseArray = [response.categoriesList.categories]
                        
                        for item in responseArray {
                            for categorieObject in item {
                                self.categorieViewModels.append(CategoriesCellViewModel(categorie: categorieObject))
                
                            }
                        }
//                print("\(self.categorieViewModels)")
                DispatchQueue.main.async {[weak self] in
                    self?.viewDelegate?.categoriesFetched()
                }
                break
            case .failure(let error):
                print(error)
            }
        }
        
    }
    func viewWasLoaded() {
        fetchCategorieList()

    }
    
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return categorieViewModels.count
        
        
    }

    func viewModel(at indexPath: IndexPath) -> CategoriesCellViewModel? {
        guard indexPath.row < categorieViewModels.count else { return nil }
        return categorieViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < categorieViewModels.count else { return }
    }
}
