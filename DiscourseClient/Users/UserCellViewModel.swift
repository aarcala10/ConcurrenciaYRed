//
//  UsersCellViewModell.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 05/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCellViewModel {
    let users: Users
    var textLabelText: String?
    var imageLabel: UIImage?
    
    
    
    init(users: Users) {
        self.users = users
        // TODO: Asignar textLabelText, el título del topic
        textLabelText = users.user.username
        
        var imagenUser = users.user.avatarTemplate
        
        
        if let range: Range = imagenUser.range(of: "{size}")
        {
            imagenUser.replaceSubrange(range, with: "100")
            
        }
        
        DispatchQueue.global(qos:.userInitiated).async { [weak self] in
            let url = "https://mdiscourse.keepcoding.io/\(imagenUser)"
            if let data = try? Data(contentsOf: URL(string: url)!) {
            let image = UIImage(data: data)
                self?.imageLabel = image
            }else {
                self?.imageLabel = UIImage(systemName: "person")
            }
        }
        
        
    }
}
