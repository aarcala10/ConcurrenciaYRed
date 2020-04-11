//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class TopicDetailViewController: UIViewController {

    lazy var labelTopicID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelTopicPosts: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = NSLocalizedString("Topic ID: ", comment: "")
        labelTopicIDTitle.textColor = .black
        

        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal
        
        

        return topicIDStackView
    }()
    

    lazy var topicNameStackView: UIStackView = {
        let labelTopicTitleTitle = UILabel()
        labelTopicTitleTitle.text = NSLocalizedString("Topic name: ", comment: "")
        labelTopicTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let topicNameStackView = UIStackView(arrangedSubviews: [labelTopicTitleTitle, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal
        
        

        return topicNameStackView
    }()
    
    lazy var topicPostsStackView: UIStackView = {
        let labelTopicPostsTitle = UILabel()
        labelTopicPostsTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicPostsTitle.text = NSLocalizedString("Posts: ", comment: "")

        let topicPostsStackView = UIStackView(arrangedSubviews: [labelTopicPostsTitle, labelTopicPosts])
        topicPostsStackView.translatesAutoresizingMaskIntoConstraints = false
        topicPostsStackView.axis = .horizontal

        return topicPostsStackView
    }()
    

    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(topicPostsStackView)
        NSLayoutConstraint.activate([
            topicPostsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicPostsStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 8)
        ])

        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        
    }

    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc func delButtonTapped() {
        viewModel.delButtonTapped()
    }

    fileprivate func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showErrorDeletedTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error deleting!!\nIs posible that this topic was deleted.\nPlease, try in 24h.", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI() {
        labelTopicID.text = viewModel.labelTopicIDText
        labelTopicTitle.text = viewModel.labelTopicNameText
        labelTopicPosts.text = viewModel.labelTopicPostsText
        
        let showDeleted = viewModel.modeUserDeleted
        
        func showUserDeletedButton(){
            if showDeleted == true {
                let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(delButtonTapped))
                rightBarButtonItem.tintColor = .black
                navigationItem.rightBarButtonItem = rightBarButtonItem
            }
        }
        showUserDeletedButton()
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
   
    
    func topicDetailFetched() {
        
        updateUI()
    }

    func errorFetchingTopicDetail() {
        DispatchQueue.main.async { [weak self] in
            self?.showErrorFetchingTopicDetailAlert()
        }
    }
    
    func topicDetailErrorDelTopic() {
//        print("no puedes borrar este topic")
        DispatchQueue.main.async { [weak self] in
            self?.showErrorDeletedTopicDetailAlert()
        }
    }
}
