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
            textLabel?.text = viewModel.textLabelText
            imageView?.image = viewModel.imageLabel
            
        }
    }
}

extension UserCell: CellViewDelegate {
    func userImageFetched() {
        imageView?.image = viewModel?.imageLabel
        setNeedsLayout()
    }
}

