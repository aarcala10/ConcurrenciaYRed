//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 09/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    lazy var labelUserID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelUserUsername: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelUserName: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    lazy var textFieldUserName: UITextField = {
        let textFieldUserName = UITextField()
        textFieldUserName.translatesAutoresizingMaskIntoConstraints = false
        textFieldUserName.borderStyle = .roundedRect

        return textFieldUserName
    }()
    
    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("User ID: ", comment: "")
        labelUserIDTitle.textColor = .black
        

        let userIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, labelUserID])
        userIDStackView.translatesAutoresizingMaskIntoConstraints = false
        userIDStackView.axis = .horizontal
        
        

        return userIDStackView
    }()
    
    lazy var userNameStackView: UIStackView = {
        let labelUserNameTitle = UILabel()
        labelUserNameTitle.text = NSLocalizedString("Name: ", comment: "")
        labelUserNameTitle.translatesAutoresizingMaskIntoConstraints = false

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserNameTitle, labelUserName])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .horizontal
        
        

        return userNameStackView
    }()
    
    lazy var userNameTextStackView: UIStackView = {
        let textFieldUserNameTitle = UILabel()
        textFieldUserNameTitle.text = NSLocalizedString("Name: ", comment: "")
        textFieldUserNameTitle.translatesAutoresizingMaskIntoConstraints = false

        let userNameTextStackView = UIStackView(arrangedSubviews: [textFieldUserNameTitle, textFieldUserName])
        userNameTextStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameTextStackView.axis = .horizontal
        
        

        return userNameTextStackView
    }()
    
    lazy var userUsernameStackView: UIStackView = {
        let labelUserUsernameTitle = UILabel()
        labelUserUsernameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserUsernameTitle.text = NSLocalizedString("Username: ", comment: "")

        let userUsernameStackView = UIStackView(arrangedSubviews: [labelUserUsernameTitle, labelUserUsername])
        userUsernameStackView.translatesAutoresizingMaskIntoConstraints = false
        userUsernameStackView.axis = .horizontal

        return userUsernameStackView
    }()
    
    let viewModel: UserDetailViewModel

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(userNameStackView)
        NSLayoutConstraint.activate([
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(userNameTextStackView)
        NSLayoutConstraint.activate([
            userNameTextStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameTextStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(userUsernameStackView)
        NSLayoutConstraint.activate([
            userUsernameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userUsernameStackView.topAnchor.constraint(equalTo: userNameStackView.bottomAnchor, constant: 8),
            userUsernameStackView.topAnchor.constraint(equalTo: userNameTextStackView.bottomAnchor, constant: 8)
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
    
    @objc func editButtonTapped() {
        viewModel.editButtonTapped()
    }
    
    
    fileprivate func showErrorFetchingUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching user detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showErrorEditUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error editing name!!\nThis name may have already been edited.", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showUserEditedAlert() {
        let alertMessage: String = NSLocalizedString("The name has been edited!!", comment: "")
        showAlert(alertMessage)
    }
    
    
    fileprivate func updateUI() {
        labelUserID.text = viewModel.labelUserIDText
        labelUserName.text = viewModel.labelUserNameText
        labelUserUsername.text = viewModel.labelUserUsernameText
        textFieldUserName.placeholder = viewModel.labelUserNameText
        
        let showEdit = viewModel.modeUserEdit
            
        func showUserEditButton(){
            if showEdit == true {
                userNameStackView.isHidden = true
                userNameTextStackView.isHidden = false
            }else{
                userNameTextStackView.isHidden = false
                userNameTextStackView.isHidden = true
            }
        }
        showUserEditButton()
    }
    
}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailFetched() {
        updateUI()
    }
    
    func errorFetchingUserDetail() {
        DispatchQueue.main.async { [weak self] in
            self?.showErrorFetchingUserDetailAlert()
        }
    }
    
    func userEdited(){
        DispatchQueue.main.async { [weak self] in
            self?.showUserEditedAlert()
        }
    }
    
   func userDetailErrorEditUser() {
   //        print("no puedes borrar este topic")
        DispatchQueue.main.async {[weak self] in
            self?.showErrorEditUserDetailAlert()
        }
    }
 
}


