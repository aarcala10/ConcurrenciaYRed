//
//  CategorieCell.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 04/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class CategorieCell: UITableViewCell {
    var viewModel: CategoriesCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
            
        }
    }
}
