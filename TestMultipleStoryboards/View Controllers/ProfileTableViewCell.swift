//
//  ProfileTableViewCell.swift
//  TestMultipleStoryboards
//
//  Created by Richard on 11/3/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
