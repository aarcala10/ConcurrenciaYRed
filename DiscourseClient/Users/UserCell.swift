//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewdDelegate = self
            
            DispatchQueue.main.async { [weak self] in
                self?.textLabel?.text = self?.viewModel?.textLabelText
                self?.imageView?.image = self?.viewModel?.imageLabel
                
            }
            
        }
    }
}

extension UserCell: CellViewDelegate {
    func userImageFetched() {
        imageView?.image = viewModel?.imageLabel
        setNeedsLayout()
    }
}

