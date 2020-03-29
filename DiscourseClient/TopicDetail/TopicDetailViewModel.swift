//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicDetailDelButtonTapped()
    
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func topicDetailErrorDelTopic()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var labelTopicPostsText: String?
    var modeUserDeleted: Bool?
    var topicDeleted: Bool?

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    
    var topicID: Int
    

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
        
    }

    
    func fetchTopicSingle() {
        
        topicDetailDataManager.fetchTopic (id: topicID) { result in
            switch result {
            case .success(let response):
                
                self.labelTopicNameText = "\(response.title)"
                self.labelTopicIDText = "\(response.id)"
                self.labelTopicPostsText = "\(response.postsCount)"
                
                if response.details.canDelete == true{
                    self.modeUserDeleted = response.details.canDelete}
                    
                let responseArray = [response.postStream.posts]
                for item in responseArray {
                    for detail in item {
                        self.topicDeleted = detail.userDeleted
                        
                    }
                }
                self.viewDelegate?.topicDetailFetched()
                break
            case .failure(_):
                self.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }
    
    

    func viewDidLoad() {
        fetchTopicSingle()
        
    }

    func backButtonTapped() {
        
        coordinatorDelegate?.topicDetailBackButtonTapped()
        
    }
    
    
    func errorDelTopic(){
        viewDelegate?.topicDetailErrorDelTopic()
        
    }
    
    
    
    
    func delButtonTapped() {guard let updateStatusURL = URL(string: "https://mdiscourse.keepcoding.io/t/\(topicID).json") else { return }

            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
        
            var request = URLRequest(url: updateStatusURL)
            request.httpMethod = "DELETE"
            request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
            request.addValue("aarcala10", forHTTPHeaderField: "Api-Username")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    if (response.statusCode == 200)&&(self.topicDeleted == false) {
                        print("Deleting topic...")
                        DispatchQueue.main.async {[weak self] in
                            
                            self?.coordinatorDelegate?.topicDetailDelButtonTapped()
                        }
                    }
                    print("\(response.statusCode)")
                    
                }
                print ("Error deleting topic...")
                self.viewDelegate?.topicDetailErrorDelTopic()
                
                }
            
            
            dataTask.resume()
        
    }
        
    
            
    
}

