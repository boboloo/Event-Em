//
//  MyEventsTableViewCell.swift
//  TestMultipleStoryboards
//
//  Created by xjosuex7 on 11/7/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit

class MyEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myEvents: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
