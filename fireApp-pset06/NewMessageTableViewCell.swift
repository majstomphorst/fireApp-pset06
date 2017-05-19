//
//  NewMessageTableViewCell.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 19/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit

class NewMessageTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var usersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
