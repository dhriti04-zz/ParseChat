//
//  ChatCell.swift
//  ParseChat
//
//  Created by Dhriti Chawla on 2/5/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
