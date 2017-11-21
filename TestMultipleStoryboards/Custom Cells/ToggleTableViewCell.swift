//
//  ToggleTableViewCell.swift
//  TestMultipleStoryboards
//
//  Created by Richard on 11/18/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit

class ToggleTableViewCell: UITableViewCell {

    @IBOutlet weak var eventCategory: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
