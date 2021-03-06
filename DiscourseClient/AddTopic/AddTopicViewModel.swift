//
//  AddTopicViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate para comunicar aspectos relacionados con navegación
protocol AddTopicCoordinatorDelegate: class {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

/// Delegate para comunicar a la vista aspectos relacionados con UI
protocol AddTopicViewDelegate: class {
    func errorAddingTopic()
}

class AddTopicViewModel {
    weak var viewDelegate: AddTopicViewDelegate?
    weak var coordinatorDelegate: AddTopicCoordinatorDelegate?
    let dataManager: AddTopicDataManager

    init(dataManager: AddTopicDataManager) {
        self.dataManager = dataManager
    }

    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }

    func submitButtonTapped(title: String, raw: String) {
        /** TODO:
         Realizar la llamada addTopic sobre el dataManager.
         Si el resultado es success, avisar al coordinator
         Si la llamada falla, avisar al viewDelegate
         */
        let title = title
        let raw =  raw
        
        dataManager.addTopic(title: title, raw: raw) { result in
            switch result {
                case .success(_):
                /*
                 Este main.async tampoco haría falta puesto que todos los closures que se llaman
                 desde SessionAPI se llaman dentro de main.async, por tanto lo estaríamos haciendo
                 dos veces
                 */
                DispatchQueue.main.async {[weak self] in
                        self?.coordinatorDelegate?.topicSuccessfullyAdded()
                    }
                case .failure(_):
                    print("Error adding topic")
                    /*
                     Este main.async tampoco haría falta puesto que todos los closures que se llaman
                     desde SessionAPI se llaman dentro de main.async, por tanto lo estaríamos haciendo
                     dos veces
                     */
                    DispatchQueue.main.async { [weak self] in
                        self?.viewDelegate?.errorAddingTopic()
                }
                    
            
            
            }
        }
    }
}
