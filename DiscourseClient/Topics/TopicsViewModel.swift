//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }
    
    func fetchTopicList() {
                topicViewModels = []

        /*
         NO hace falta la global queue porque el dataTask.reusme() ya hace su trabajo en una
         cola que on es la main.
         */
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            self?.topicsDataManager.fetchAllTopics { result in
            switch result {
            case .success(let response):
                
                let responseArray = [response.topicList.topics]
                
                for item in responseArray {
                    for topicObject in item {
                        self?.topicViewModels.append(TopicCellViewModel(topic: topicObject))
        
                    }
                }
                
//                print("\(self.topicViewModels)")
                /*
                 Este main.async tampoco haría falta puesto que todos los closures que se llaman
                 desde SessionAPI se llaman dentro de main.async, por tanto lo estaríamos haciendo
                 dos veces
                 */
                DispatchQueue.main.async {[weak self] in
                    self?.viewDelegate?.topicsFetched()
                    
                }
                break
            case .failure(let error):
                print(error)
            }
            }
        }
        
    }
    func viewWasLoaded() {
        /** TODO:
         Recuperar el listado de latest topics del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos topics listos para pintar
         */
        fetchTopicList()
    }
        
    

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        coordinatorDelegate?.didSelect(topic: topicViewModels[indexPath.row].topic)
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }
    
    
    func newTopicWasCreated() {
        // TODO: Seguramente debamos recuperar de nuevo los topics del datamanager, y pintarlos de nuevo
        
        fetchTopicList()
    }
    
}
