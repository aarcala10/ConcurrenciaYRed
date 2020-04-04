//
//  CategoriesViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController para representar el listado de categorías
class CategoriesViewController: UIViewController {
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "CategorieCell", bundle: nil), forCellReuseIdentifier: "CategorieCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    let viewModel: CategoriesViewModel


    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
    fileprivate func showErrorFetchingCategoriesAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching categories\nPlease try again later", comment: "")
        showAlert(alertMessage)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieCell", for: indexPath) as? CategorieCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel

            return cell
            
        }

        fatalError()
    }
    
}
extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
        
    }
}

extension CategoriesViewController: CategoriesViewDelegate {
    func categoriesFetched(){
        tableView.reloadData()
        print ("Categories list LOADED")
    }

    
    func errorFetchingCategories() {
        showErrorFetchingCategoriesAlert()
    }
}
